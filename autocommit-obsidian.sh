#!/bin/bash

set -euo pipefail

OBSIDIAN_DIRECTORY= $OBSIDIAN_VAULT_PATH
if find "$OBSIDIAN_DIRECTORY" -type f -newermt "$(date +%Y-%m-%d)" ! -name "*.log" | grep -q .; then
    echo "[INFO] Changes detected in '$OBSIDIAN_DIRECTORY'."
    cd "$OBSIDIAN_DIRECTORY" || exit 1

    echo "[INFO] Starting commit process..."

    echo "[INFO] The following files will be staged:"
    git status

    echo "[INFO] Adding files to the staging area..."
    git add .

    _COMMIT_DATE=$(date +%Y-%m-%d)

    echo "[INFO] Performing commit..."
    git commit -m "$_COMMIT_DATE" || {
        echo "[WARN] Nothing to commit."
        exit 0
    }

    echo "[INFO] Pushing to remote repository..."
    git push

    echo "[INFO] Process completed successfully."
else
    echo "[INFO] No changes found."
fi

