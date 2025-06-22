#!/bin/bash

# Enhanced Git push helper script
set -e  # Exit on error

echo "🚀 Starting GitHub push process..."

# Pull latest changes first to avoid conflicts
echo "🔁 Pulling latest changes from GitHub..."
if ! git pull origin main; then
    echo "❌ Error: Failed to pull changes. Resolve conflicts and try again."
    exit 1
fi

# Stage all changes
echo "📦 Staging all changes..."
git add .

# Check if there are changes to commit
if [ -z "$(git status --porcelain)" ]; then
    echo "✅ No changes to commit."
    exit 0
fi

# Commit changes with interactive message
echo "💬 Enter commit message (Ctrl+D to finish):"
commit_msg=$(</dev/stdin)
git commit -m "$commit_msg"

# Confirm before pushing
read -p "⚠️ Push changes to GitHub? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Push cancelled."
    exit 0
fi

# Push changes
echo "🚀 Pushing changes to GitHub..."
if git push origin main; then
    echo "✅ Changes successfully pushed to GitHub."
else
    echo "❌ Push failed. Check your network connection or permissions."
    exit 1
fi