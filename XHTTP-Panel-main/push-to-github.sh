#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}=== GitHub Push Script (Updated) ===${NC}"

# Check git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo -e "${YELLOW}Initializing git repository...${NC}"
    git init
fi

# Get repo URL
if [ -z "$1" ]; then
    echo -e "${YELLOW}Enter GitHub repo URL:${NC}"
    read -r REPO_URL
else
    REPO_URL="$1"
fi

[[ -z "$REPO_URL" ]] && { echo -e "${RED}No URL provided.${NC}"; exit 1; }

# Stage & commit
echo -e "${YELLOW}Staging and committing...${NC}"
git add .
if ! git diff --cached --quiet; then
    git commit -m "Initial commit" || true
else
    echo "No changes to commit."
fi

# Remove old origin
if git remote | grep -q "^origin$"; then
    echo -e "${YELLOW}Removing old origin...${NC}"
    git remote remove origin
fi

# Add new origin
echo -e "${YELLOW}Adding origin...${NC}"
git remote add origin "$REPO_URL"

git branch -M main 2>/dev/null || true

echo -e "${GREEN}Pushing to GitHub...${NC}"
echo -e "${YELLOW}Tip: Use a Personal Access Token (PAT) as password, not your GitHub password.${NC}"

if git push -u origin main; then
    echo -e "${GREEN}✅ Successfully pushed!${NC}"
else
    echo -e "${RED}❌ Push failed.${NC}"
    echo ""
    echo "Common fixes:"
    echo "1. Create the repository on GitHub first (empty, no README/.gitignore)"
    echo "2. Generate a PAT: https://github.com/settings/tokens → Classic Token → repo scope"
    echo "3. Use the PAT as the password when prompted"
    echo "4. Or better: Use SSH (recommended)"
    exit 1
fi
