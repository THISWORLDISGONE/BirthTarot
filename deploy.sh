#!/bin/bash

# Add all changes
git add .

# Commit changes with a timestamp
commit_message="Deploy update: $(date +'%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_message"

# Push to GitHub
git push origin main