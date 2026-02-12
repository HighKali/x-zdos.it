#!/bin/bash

echo "🛠️ Risanificazione GitHub Actions in corso..."

cd ~/x-zdos.it || { echo "❌ Cartella x-zdos.it non trovata"; exit 1; }

mkdir -p .github/workflows

cat <<EOF > .github/workflows/deploy.yml
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v4

      - name: Setup Pages
        uses: actions/configure-pages@v3

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v2
        with:
          path: '.'

      - name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v2
EOF

git add .github/workflows/deploy.yml
git commit -m "🛠️ Fix GitHub Actions: deploy.yml rigenerato"
git push origin main

echo "✅ Workflow risanato. Verifica su: https://github.com/high-cde/x-zdos.it/actions"

