#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/zaidon87/scaling_laws_MMC_computing.git"

git init
git add .
git commit -m "Initial scientific repository for MMC scaling laws"
git branch -M main
git remote add origin "$REPO_URL"
git push -u origin main
