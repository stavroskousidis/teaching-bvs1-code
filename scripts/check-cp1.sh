#!/bin/sh
set -eu

QEMU="${QEMU:-qemu-system-riscv64}"
ELF="${BVS1_CP1_ELF:-build/hello-bvs1.elf}"
TIMEOUT="${BVS1_CP1_TIMEOUT:-6}"
LOG="${BVS1_CP1_LOG:-build/check-cp1.log}"
NORMALIZED="${LOG}.normalized"

if [ ! -f "${ELF}" ]; then
    echo "CP1 check: ELF not found: ${ELF}" >&2
    exit 1
fi

mkdir -p "$(dirname "${LOG}")"

set +e
timeout "${TIMEOUT}s" "${QEMU}" \
    -machine virt \
    -m 128M \
    -smp 1 \
    -nographic \
    -bios none \
    -kernel "${ELF}" > "${LOG}" 2>&1
status=$?
set -e

if [ "${status}" -ne 0 ] && [ "${status}" -ne 124 ]; then
    cat "${LOG}"
    echo "CP1 check: QEMU exited unexpectedly with status ${status}." >&2
    exit "${status}"
fi

tr -d '\r' < "${LOG}" > "${NORMALIZED}"

expected='
exercise: seed 11
process: before yield 34
os: process yielded
process: result 177
os: process exited 177
'

previous=0
printf '%s\n' "${expected}" | while IFS= read -r line; do
    [ -n "${line}" ] || continue

    current="$(grep -nFx -m1 "${line}" "${NORMALIZED}" | cut -d: -f1 || true)"
    if [ -z "${current}" ]; then
        cat "${NORMALIZED}"
        echo "CP1 check: missing expected line: ${line}" >&2
        exit 1
    fi

    if [ "${current}" -le "${previous}" ]; then
        cat "${NORMALIZED}"
        echo "CP1 check: lifecycle output is out of order at: ${line}" >&2
        exit 1
    fi

    previous="${current}"
done

if grep -Fq "reference: FAIL:" "${NORMALIZED}"; then
    cat "${NORMALIZED}"
    echo "CP1 check: reference implementation reported a failure." >&2
    exit 1
fi

echo "CP1 observable behaviour OK."
