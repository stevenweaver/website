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

# Build the site
echo -e "${BLUE}Building site...${NC}"
yarn build

if [ ! -d "$BUILD_DIR" ]; then
    echo -e "${RED}Error: Build directory '$BUILD_DIR' not found!${NC}"
    exit 1
fi

echo -e "${GREEN}Build completed successfully${NC}"

# Deploy to NearlyFreeSpeech.Net
echo -e "${BLUE}Deploying to ${REMOTE_HOST}...${NC}"

rsync -avz --delete \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='.DS_Store' \
    "$BUILD_DIR/" \
    "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

echo -e "${GREEN}Deployment completed successfully!${NC}"
echo -e "${BLUE}Site should be live at your domain${NC}"
