#!/bin/bash
set -e

REPO_URL="https://github.com/gurcangul/refactored-couscous.git"
DEPLOY_DIR="_deploy_tmp"

echo "=== Building food/ (React 17) ==="
cd food && npm run build && cd ..

echo "=== Building portal/ (React 18) ==="
cd portal && npm run build && cd ..

echo "=== Building news/ (React 18) ==="
cd news && npm run build && cd ..

echo "=== Preparing build branch ==="
rm -rf $DEPLOY_DIR
mkdir -p $DEPLOY_DIR/food
mkdir -p $DEPLOY_DIR/portal
mkdir -p $DEPLOY_DIR/news

cp -r food/dist/. $DEPLOY_DIR/food/
cp -r portal/dist/. $DEPLOY_DIR/portal/
cp -r news/dist/. $DEPLOY_DIR/news/

echo "=== Pushing to build branch ==="
cd $DEPLOY_DIR
git init
git checkout -b build
git add -A
git commit -m "deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git remote add origin $REPO_URL
git push -f origin build

cd ..
rm -rf $DEPLOY_DIR

echo "=== Done. build branch updated with food/, portal/, news/ ==="
