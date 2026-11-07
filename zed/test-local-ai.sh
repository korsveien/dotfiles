#!/usr/bin/env bash
# Test script to verify the local AI setup for Zed

set -euo pipefail

echo "Testing Local AI Setup for Zed"
echo "================================"
echo ""

# Check Tailscale
if ! command -v tailscale &>/dev/null; then
    echo "❌ Tailscale is not installed"
    exit 1
fi

if ! tailscale status &>/dev/null; then
    echo "⚠️  Tailscale is not running. Start it first."
    exit 1
fi

echo "✅ Tailscale is running"
tailscale_dns=$(tailscale status --json | python3 -c 'import json,sys; print(json.load(sys.stdin)["Self"]["DNSName"])' 2>/dev/null)
echo "   Your Tailscale DNS: $tailscale_dns"

# Check if we're on the adelie-pirate tailnet
if echo "$tailscale_dns" | grep -q "adelie-pirate.ts.net"; then
    echo "✅ Connected to adelie-pirate.ts.net tailnet"
else
    echo "⚠️  Not connected to adelie-pirate.ts.net tailnet"
    echo "   Current tailnet: $tailscale_dns"
fi

echo ""

# Test connection to MacBook Pro
macbook_url="https://bekk-mac-3262.adelie-pirate.ts.net"
echo "Testing connection to MacBook Pro: $macbook_url"

if curl -s -k -o /dev/null -w "%{http_code}" "$macbook_url/v1/models" | grep -q "200"; then
    echo "✅ Connection successful!"
    echo ""
    echo "Available models:"
    curl -s -k "$macbook_url/v1/models" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    for model in data.get('data', []):
        print(f'  ✓ {model[\"id\"]} - {model.get(\"description\", \"\"):60}')
except:
    print('  Error parsing response')
"
else
    echo "❌ Cannot connect to MacBook Pro"
    echo "   Check if:"
    echo "   1. MacBook Pro (bekk-mac-3262) is online"
    echo "   2. llama-server is running on MacBook Pro"
    echo "   3. Tailscale is connected on MacBook Pro"
    exit 1
fi

echo ""
echo "✅ All checks passed!"
echo ""
echo "You can now use local AI in Zed with provider: llama-server-macbook"
