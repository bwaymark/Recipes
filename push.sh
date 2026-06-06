#!/bin/bash

RECIPES_DIR="/Users/benwaymark/Library/Mobile Documents/iCloud~md~obsidian/Documents/Ben/Recipes"
REPO_DIR="$HOME/recipes-repo"
REMOTE="git@github.com:bwaymark/Recipes.git"

# Clone the repo if it doesn't exist locally yet
if [ ! -d "$REPO_DIR" ]; then
    git clone "$REMOTE" "$REPO_DIR"
fi

# Copy recipes into the repo
rsync -av --delete \
    --exclude='.git' \
    "$RECIPES_DIR/" "$REPO_DIR/"

# Commit and push if there are changes
cd "$REPO_DIR"

if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "new recipe(s)"
    git push origin main
    echo "Recipes synced and pushed."
else
    echo "No changes to push."
fi
