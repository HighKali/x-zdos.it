#!/bin/bash
mkdir -p agents
cat <<JSON > agents/feed.json
[
  {
    "time": "23:41:03",
    "agent": "XZDOS_AOA",
    "message": "Terminale xCLOUD operativo. Nessuna minaccia rilevata."
  },
  {
    "time": "23:41:03",
    "agent": "AGENT_KALI",
    "message": "Z-AI_AOA sincronizzato. Stato: stabile."
  }
]
JSON
