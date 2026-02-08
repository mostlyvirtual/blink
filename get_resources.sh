#!/bin/bash
set -e

# Expected SHA256 checksum for the vim runtime.zip
EXPECTED_CHECKSUM="4c7e46339e59c4cd61178f5e52b33b22b399c112ef8292dd31a8e1f7243b825d"

(
    cd Resources/vim
    curl -L https://github.com/blinksh/vim/releases/download/v9.1.0187/runtime.zip > runtime.zip
    
    # Validate checksum
    ACTUAL_CHECKSUM=$(sha256sum runtime.zip | awk '{print $1}')
    if [ "$ACTUAL_CHECKSUM" != "$EXPECTED_CHECKSUM" ]; then
        echo "ERROR: Checksum validation failed!"
        echo "Expected: $EXPECTED_CHECKSUM"
        echo "Got:      $ACTUAL_CHECKSUM"
        rm runtime.zip
        exit 1
    fi
    
    echo "Checksum validated successfully"
    unzip runtime.zip && mv runtime/* ./ && rm runtime.zip
)

echo "done"
