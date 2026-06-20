#!/bin/bash

# =============================================
# GitHub Push Script - Removes previous origin
# =============================================

set -e  # Exit on error

# Colors for nice output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== GitHub Push Script ===${NC}"

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo -e "${YELLOW}Not a git repository. Initializing...${NC}"
    git init
fi

# Get the repository URL from argument or ask for it
if [ -z "$1" ]; then
    echo -e "${YELLOW}Enter your GitHub repository URL (e.g. https://github.com/username/repo.git):${NC}"
    read -r REPO_URL
else
    REPO_URL="$1"
fi

if [ -z "$REPO_URL" ]; then
    echo -e "${RED}Error: No repository URL provided.${NC}"
    exit 1
fi

# Stage all files
echo -e "${YELLOW}Staging files...${NC}"
git add .

# Commit if there are changes
if git diff --cached --quiet; then
    echo -e "${YELLOW}No changes to commit.${NC}"
else
    echo -e "${YELLOW}Committing changes...${NC}"
    git commit -m "Initial commit"
fi

# Remove previous origin if it exists
if git remote | grep -q "^origin$"; then
    echo -e "${YELLOW}Removing previous origin...${NC}"
    git remote remove origin
fi

# Add new origin
echo -e "${YELLOW}Adding new origin...${NC}"
git remote add origin "$REPO_URL"

# Verify remote
echo -e "${YELLOW}Remote set to:${NC} $REPO_URL"

# Push to GitHub
echo -e "${GREEN}Pushing to GitHub...${NC}"
git branch -M main 2>/dev/null || true  # Rename to main if needed

if git push -u origin main; then
    echo -e "${GREEN}✅ Successfully pushed to GitHub!${NC}"
else
    echo -e "${RED}❌ Push failed. Make sure:${NC}"
    echo "   • The repository exists on GitHub"
    echo "   • You have push access"
    echo "   • You are authenticated (git config --global user.name/email set)"
    exit 1
fi
