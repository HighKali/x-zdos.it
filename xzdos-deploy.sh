#!/bin/bash

echo "🚀 Deploy completo di x-zdos.it in corso..."

cd ~/x-zdos.it || { echo "❌ Cartella x-zdos.it non trovata"; exit 1; }

# 1. index.html
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>XCLOUD × ZDOS</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="manifest" href="manifest.json" />
  <style>
    body { background: #0a0a0a; color: #00ff88; font-family: monospace; margin: 0; padding: 2rem; }
    h1, h2 { text-align: center; }
    .terminal { background: #111; border: 1px solid #00ff88; padding: 1rem; margin: 2rem 0; }
    .card { border: 1px solid #00ff88; padding: 1rem; margin: 1rem 0; background: #000; }
    .card h3 { margin-top: 0; color: #0ff; }
    a { color: #00ffff; text-decoration: none; }
    footer { text-align: center; font-size: 0.8rem; color: #666; margin-top: 3rem; }
  </style>
</head>
<body>
  <h1>XCLOUD × ZDOS</h1>
  <div class="terminal" id="terminal">
    cloudx@xdos:~$ booting agent XZDOS_AOA...<br>
    [23:37] [XZDOS_AOA]: Terminale operativo<br>
    [23:37] [AGENT_KALI]: Z-AI_AOA sincronizzato<br>
  </div>

  <div class="card">
    <h3>Z-GENESIS-OS</h3>
    <p>Sistema operativo sintetico, auto-riparante, orchestrato da Z-AI_AOA.</p>
    <a href="https://high-cde.github.io/Z-GENESIS-OS/" target="_blank">Vai al terminale</a>
  </div>

  <div class="card">
    <h3>XZDOS_AOA</h3>
    <p>Stack agentivo: social, sentinel, controllo, runtime distribuito.</p>
    <a href="https://high-cde.github.io/xZDOS_AOA/" target="_blank">Accedi</a>
  </div>

  <div class="card">
    <h3>XCLOUD Civic Lab</h3>
    <p>Fork industriale del Bitrix24 DevHub, rebrandizzato per l’ecosistema CloudX × ZDOS. Include DSN Layer, Portal Fusion, Nexus, Terminale e pipeline enterprise-ready.</p>
    <a href="https://high-cde.github.io/Cloudx-site-by-zdos/" target="_blank">Esplora</a>
  </div>

  <div class="card">
    <h3>Whitepaper & Roadmap</h3>
    <p>Scopri la visione del token \$DSN e le potenzialità di XCLOUD.</p>
    <a href="whitepaper-dsn.pdf" target="_blank">Whitepaper \$DSN</a> |
    <a href="roadmap-xcloud.pdf" target="_blank">Roadmap XCLOUD</a>
  </div>

  <div class="card">
    <h3>Chi siamo</h3>
    <p>X-ZDOS ENTERPRISE è un ecosistema sintetico nato dalla collaborazione tra <strong>HighCDE</strong>, <strong>HighKali</strong> e <a href="https://www.instagram.com/lanovavon26" target="_blank">@lanovavon26</a>.</p>
  </div>

  <footer>
    © 2026 XCLOUD × ZDOS · MIT / BUSL-1.1 / CC BY-NC-ND 4.0 · <a href="https://github.com/high-cde" target="_blank">GitHub</a>
  </footer>
</body>
</html>
EOF

# 2. manifest.json
cat <<EOF > manifest.json
{
  "name": "XCLOUD × ZDOS",
  "short_name": "XZDOS",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#000000",
  "theme_color": "#00ff88",
  "icons": []
}
EOF

# 3. service-worker.js
cat <<EOF > service-worker.js
self.addEventListener('install', e => {
  e.waitUntil(caches.open('xzdos-cache').then(cache => cache.addAll(['/index.html'])));
});
self.addEventListener('fetch', e => {
  e.respondWith(caches.match(e.request).then(response => response || fetch(e.request)));
});
EOF

# 4. update-feed.sh
cat <<EOF > update-feed.sh
#!/bin/bash
mkdir -p agents
cat <<JSON > agents/feed.json
[
  {
    "time": "$(date +%H:%M:%S)",
    "agent": "XZDOS_AOA",
    "message": "Terminale xCLOUD operativo. Nessuna minaccia rilevata."
  },
  {
    "time": "$(date +%H:%M:%S)",
    "agent": "AGENT_KALI",
    "message": "Z-AI_AOA sincronizzato. Stato: stabile."
  }
]
JSON
EOF
chmod +x update-feed.sh

# 5. whitepaper-dsn.pdf (simulato)
echo "Whitepaper $DSN — Il token DSN è progettato per alimentare l’economia sintetica dell’ecosistema ZDOS. Funziona come unità di reputazione, accesso e governance. Ogni transazione è tracciata, ogni contributo è premiato. DSN è interoperabile, scalabile e integrato con il wallet CloudX." > whitepaper-dsn.pdf

# 6. roadmap-xcloud.pdf (simulato)
echo "Roadmap XCLOUD — Q1: Civic Lab + Wallet. Q2: Terminale CloudX + Nexus. Q3: Fusion Layer + DSN Governance. Q4: AI Orchestration + Enterprise SDK. Tutto orchestrato da Z-AI_AOA." > roadmap-xcloud.pdf

# 7. Commit e push
git add .
git commit -m "🔥 Deploy completo: index, terminale, allegati, manifest"
git push origin main

echo "✅ Tutto pronto. Visita: https://high-cde.github.io/x-zdos.it/"
