#!/bin/bash
set -e

# Expected SHA256 checksum for cacert.pem
# This should be updated when the CA certificate bundle is updated
# Current checksum is for the version as of Feb 2026
EXPECTED_CHECKSUM="23c2469e2a568362a62eecf1b49ed90a15621e6fa30e29947ded3436422de9b9"

# Download the CA certificate bundle
curl -o Resources/cacert.pem https://curl.se/ca/cacert.pem

# Validate checksum
ACTUAL_CHECKSUM=$(sha256sum Resources/cacert.pem | awk '{print $1}')
if [ "$ACTUAL_CHECKSUM" != "$EXPECTED_CHECKSUM" ]; then
    echo "ERROR: Checksum validation failed!"
    echo "Expected: $EXPECTED_CHECKSUM"
    echo "Got:      $ACTUAL_CHECKSUM"
    echo ""
    echo "If this is an intentional update to the CA certificate bundle,"
    echo "please update the EXPECTED_CHECKSUM in this script."
    rm Resources/cacert.pem
    exit 1
fi

echo "CA certificate bundle downloaded and validated successfully"
