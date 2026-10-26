#!/bin/bash

# Deploy script for stevenweaver.com
# Builds the SvelteKit site and deploys to NearlyFreeSpeech.Net

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
REMOTE_USER="maximumsteve_stevenweaver"
REMOTE_HOST="ssh.nyc1.nearlyfreespeech.net"
REMOTE_PATH="/home/public/"
BUILD_DIR="build"

echo -e "${BLUE}Starting deployment...${NC}"

# NFSN login password comes from the macOS Keychain (service "nfsn-deploy") and
# is handed to ssh via sshpass. Fetched up front so a missing entry fails fast.
if ! command -v sshpass >/dev/null; then
    echo -e "${RED}Error: sshpass not installed (brew install sshpass)${NC}"
    exit 1
fi
if ! SSHPASS="$(security find-generic-password -s nfsn-deploy -a "$REMOTE_USER" -w 2>/dev/null)"; then
    echo -e "${RED}Error: no Keychain entry 'nfsn-deploy' for ${REMOTE_USER}${NC}"
    exit 1
fi
export SSHPASS
RSYNC_SSH="sshpass -e ssh"

# Build the site
echo -e "${BLUE}Building site...${NC}"
yarn build

if [ ! -d "$BUILD_DIR" ]; then
    echo -e "${RED}Error: Build directory '$BUILD_DIR' not found!${NC}"
    exit 1
fi

echo -e "${GREEN}Build completed successfully${NC}"

# Build the CV before deploying anything. The main sync below uses --delete
# against /home/public, which removes /home/public/cv; building here (before that
# sync) means a broken CV build aborts the deploy instead of leaving the live CV
# deleted.
echo -e "${BLUE}Building CV...${NC}"
(cd ../cv && yarn build)

if [ ! -d "../cv/build" ]; then
    echo -e "${RED}Error: CV build directory '../cv/build' not found after build!${NC}"
    exit 1
fi

echo -e "${GREEN}CV build completed successfully${NC}"

# Deploy to NearlyFreeSpeech.Net
echo -e "${BLUE}Deploying to ${REMOTE_HOST}...${NC}"

rsync -avz --delete -e "$RSYNC_SSH" \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='.DS_Store' \
    "$BUILD_DIR/" \
    "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

echo -e "${GREEN}Site deployment completed successfully${NC}"

# Deploy the CV into /home/public/cv. Must run AFTER the main sync above, which
# deletes /home/public/cv via --delete; this step restores it.
echo -e "${BLUE}Deploying CV to ${REMOTE_HOST}...${NC}"

rsync -avz --delete -e "$RSYNC_SSH" \
    --exclude='.DS_Store' \
    "../cv/build/" \
    "${REMOTE_USER}@${REMOTE_HOST}:/home/public/cv/"

echo -e "${GREEN}CV deployment completed successfully${NC}"

echo -e "${GREEN}Deployment completed successfully!${NC}"
echo -e "${BLUE}Site should be live at your domain${NC}"
