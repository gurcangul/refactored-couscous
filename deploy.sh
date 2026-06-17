#!/bin/bash
set -e

FTP_HOST="72.60.93.163"
FTP_USER="u432921424"
FTP_PASS="${FTP_PASS:-}"
FTP_BASE="public_html/ggul"

if [ -z "$FTP_PASS" ]; then
  echo "Usage: FTP_PASS=yourpassword bash deploy.sh"
  exit 1
fi

echo "=== Building food/ ==="
cd food && npm run build && cd ..

echo "=== Building portal/ ==="
cd portal && npm run build && cd ..

echo "=== Building news/ ==="
cd news && npm run build && cd ..

upload_dir() {
  local LOCAL_DIR=$1
  local REMOTE_DIR=$2

  find "$LOCAL_DIR" -type f | while IFS= read -r FILE; do
    RELATIVE="${FILE#$LOCAL_DIR/}"
    curl --ftp-create-dirs \
      --user "$FTP_USER:$FTP_PASS" \
      -T "$FILE" \
      "ftp://$FTP_HOST/$REMOTE_DIR/$RELATIVE" \
      && echo "  uploaded: $RELATIVE" \
      || echo "  FAILED: $RELATIVE"
  done
}

echo "=== Uploading food/ ==="
upload_dir "food/dist" "$FTP_BASE/food"

echo "=== Uploading portal/ ==="
upload_dir "portal/dist" "$FTP_BASE/portal"

echo "=== Uploading news/ ==="
upload_dir "news/dist" "$FTP_BASE/news"

echo ""
echo "=== Done! ==="
echo "  gurcangul.com/ggul/food/"
echo "  gurcangul.com/ggul/portal/"
echo "  gurcangul.com/ggul/news/"
