#!/bin/bash
set -e

if [ ! -f ".ftp.env" ]; then
  echo "ERROR: .ftp.env dosyası bulunamadı."
  exit 1
fi

source .ftp.env

if [ -z "$FTP_PASS" ]; then
  echo "ERROR: .ftp.env içinde FTP_PASS boş."
  exit 1
fi

ROOT_DIR="$(pwd)"

echo "=== Building food/ ==="
(cd "$ROOT_DIR/food" && npm run build)

echo "=== Building portal/ ==="
(cd "$ROOT_DIR/portal" && npm run build)

echo "=== Building news/ ==="
(cd "$ROOT_DIR/news" && npm run build)

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
upload_dir "$ROOT_DIR/food/dist" "food"

echo "=== Uploading portal/ ==="
upload_dir "$ROOT_DIR/portal/dist" "portal"

echo "=== Uploading news/ ==="
upload_dir "$ROOT_DIR/news/dist" "news"

echo ""
echo "=== Done! ==="
echo "  gurcangul.com/ggul/food/"
echo "  gurcangul.com/ggul/portal/"
echo "  gurcangul.com/ggul/news/"
