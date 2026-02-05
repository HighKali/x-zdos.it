#!/usr/bin/env bash
set -e

echo "=== xZ-MASTER-AGGREGATOR ==="

###############################################
# 1) CREAZIONE STRUTTURA TEMPLATE
###############################################
echo "[1/8] Creazione cartelle template e pages..."

mkdir -p templates
mkdir -p pages

###############################################
# 2) GENERAZIONE TEMPLATE MODULARI
###############################################
echo "[2/8] Generazione template HTML..."

cat > templates/header.html << 'EOF'
<header class="navbar">
  <nav class="nav-inner">
    <div class="nav-logo">xZDOS</div>
    <div class="nav-links">
      <a href="/">Home</a>
      <a href="/zdos/">ZDOS</a>
      <a href="/xCLOUD/">xCLOUD</a>
      <a href="/agents/rzai-pulciz/">RZAi‑pulciz</a>
      <a href="/clienti.html" class="new-badge">Soluzioni Aziendali</a>
      <a href="https://wallet.x-zdos.it/">Wallet</a>
    </div>
  </nav>
</header>
EOF

cat > templates/footer.html << 'EOF'
<footer class="site-footer">
  © CloudX × ZDOS — All Rights Reserved
</footer>
EOF

cat > templates/oracle.html << 'EOF'
<section id="oracle-root"></section>
EOF

cat > templates/terminal.html << 'EOF'
<section class="rzai-terminal">
  <div class="terminal-header">RZAi Terminal</div>
  <div id="terminal-output" class="terminal-output"></div>
  <input id="terminal-input" class="terminal-input" placeholder="rzai> digita un comando...">
</section>
EOF

cat > templates/admin.html << 'EOF'
<section id="admin-panel" class="admin-panel" style="display:none;">
  <h2>Admin Panel</h2>
  <p>Stato GitHub Pages: <span id="gh-status">Caricamento...</span></p>
  <p>Ultimo deploy: <span id="deploy-time">Caricamento...</span></p>
  <button id="deploy-btn" class="cta-button">Esegui Deploy</button>
</section>
EOF

###############################################
# 3) TEMPLATE BASE
###############################################
echo "[3/8] Generazione base template..."

cat > templates/base.html << 'EOF'
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{title}}</title>
  <link rel="stylesheet" href="/assets/css/style.css">
</head>

<body>

  <!-- HEADER -->
  {% include header.html %}

  <main>
    {{content}}
  </main>

  <!-- FOOTER -->
  {% include footer.html %}

  <script src="/assets/js/main.js"></script>
</body>
</html>
EOF

###############################################
# 4) GENERAZIONE PAGINE
###############################################
echo "[4/8] Generazione pagine..."

cat > pages/index.html << 'EOF'
---
layout: base
title: xZDOS Enterprise Platform
---

{% include oracle.html %}
{% include terminal.html %}
EOF

cat > pages/admin.html << 'EOF'
---
layout: base
title: Admin Panel
---

{% include admin.html %}
EOF

###############################################
# 5) BACKUP
###############################################
echo "[5/8] Backup file esistenti..."

mkdir -p backups
cp -f index.html backups/index_$(date +%s).bak || true

###############################################
# 6) SOSTITUZIONE INDEX PRINCIPALE
###############################################
echo "[6/8] Aggiornamento index.html principale..."

cat > index.html << 'EOF'
---
layout: base
title: xZDOS Enterprise Platform
---

{% include oracle.html %}
{% include terminal.html %}
EOF

###############################################
# 7) COMMIT
###############################################
echo "[7/8] Commit aggiornamenti..."

git add .
git commit -m "deploy: master aggregator + templates + modular system" || true

###############################################
# 8) PUSH + REBUILD
###############################################
echo "[8/8] Push e rebuild..."

git push || echo "Push instabile, riprova dopo"
git commit --allow-empty -m "force rebuild"
git push

echo "=== COMPLETATO: xZ-MASTER-AGGREGATOR ==="
