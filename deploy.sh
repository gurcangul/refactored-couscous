#!/bin/bash
set -e

BUILD_BRANCH=${1:-build}

echo "Building..."
npm run build

echo "Deploying to branch: $BUILD_BRANCH"

cd dist

git init
git checkout -b $BUILD_BRANCH
git add -A
git commit -m "deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git remote add origin https://github.com/gurcangul/refactored-couscous.git
git push -f origin $BUILD_BRANCH

cd ..
rm -rf dist/.git

echo "Done. Branch '$BUILD_BRANCH' updated."
