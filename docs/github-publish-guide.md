# GitHub Publish Guide

## Repository name

```text
scaling_laws_MMC_computing
```

## Option A — GitHub website

1. Open GitHub.
2. Create a new empty public or private repository named:

```text
scaling_laws_MMC_computing
```

3. Do not add README, license, or `.gitignore` on GitHub, because they already exist in this repository.
4. From Git Bash inside the local folder, run:

```bash
git init
git add .
git commit -m "Initial scientific repository for MMC scaling laws"
git branch -M main
git remote add origin https://github.com/zaidon87/scaling_laws_MMC_computing.git
git push -u origin main
```

## Option B — GitHub CLI

If `gh` is installed and authenticated:

```bash
gh repo create zaidon87/scaling_laws_MMC_computing --public --source=. --remote=origin --push
```

Use `--private` instead of `--public` if the manuscript should remain private.

## Notes

This repository contains binary research artifacts such as `.docx`, `.xlsx`, and `.png`. They are acceptable in normal Git at the current file sizes. For much larger future datasets or generated figure archives, consider Git LFS.
