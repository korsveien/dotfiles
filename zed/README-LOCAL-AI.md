# Local AI Configuration for Zed

This configuration enables Zed to use the local AI (llama-server) running on your MacBook Pro via Tailscale.

## Configuration Added

The `settings.json` file now includes:

### Language Models Provider
```json
"language_models": {
  "llama-server-macbook": {
    "api_url": "https://bekk-mac-3262.adelie-pirate.ts.net",
    "api_key": "not-required",
    "available_models": [
      {"name": "gpt-oss-20b", "display_name": "GPT-OSS 20B", "max_tokens": 32768},
      {"name": "qwen3-30b", "display_name": "Qwen3 30B", "max_tokens": 32768},
      {"name": "qwen3-coder-30b", "display_name": "Qwen3 Coder 30B", "max_tokens": 32768},
      {"name": "gemma-3-27b", "display_name": "Gemma 3 27B", "max_tokens": 32768}
    ]
  }
}
```

### Network Permissions
Added to `sandbox_permissions.network_hosts`:
- `bekk-mac-3262.adelie-pirate.ts.net` - Direct access to MacBook Pro
- `*.adelie-pirate.ts.net` - Access to all hosts on the tailnet

## Prerequisites

### On MacBook Pro (bekk-mac-3262)
1. **Install llama-server**:
   ```bash
   cd ~/Developer/homelab
   ./mac/llama-server/install.sh
   ```

2. **Verify it's running**:
   ```bash
   curl http://127.0.0.1:9931/v1/models
   ```

### On This Machine
1. **Tailscale**: Must be connected to `adelie-pirate.ts.net`
2. **Zed**: Must be running with this configuration

## Usage in Zed

### Selecting the AI Provider
1. Open Zed
2. Open Command Palette (⌘+K or Ctrl+K)
3. Type `/ask` or use any AI feature
4. Zed should automatically detect the new provider

### Manual Selection
If prompted to choose a model:
- Select `llama-server-macbook` as the provider
- Choose from the available models:
  - **GPT-OSS 20B** (~12 GB) - Fast, good at reasoning
  - **Qwen3 30B** (~19 GB) - General chat
  - **Qwen3 Coder 30B** (~19 GB) - Code generation
  - **Gemma 3 27B** (~17 GB) - Multi-modal (images)

### Setting as Default
To use this provider by default, you can update the `agent` section in `settings.json`:
```json
"agent": {
  "inline_assistant_model": {
    "provider": "llama-server-macbook",
    "model": "qwen3-coder-30b"
  },
  "commit_message_model": {
    "provider": "llama-server-macbook",
    "model": "gpt-oss-20b"
  },
  ...
}
```

## Troubleshooting

### "Connection failed" or timeout
1. **Check Tailscale**:
   ```bash
   tailscale status
   ```
   Ensure you're connected to `adelie-pirate.ts.net`

2. **Check MacBook Pro**:
   ```bash
   # On the MacBook Pro
   pgrep -l llama-server
   ```

3. **Test API directly**:
   ```bash
   curl https://bekk-mac-3262.adelie-pirate.ts.net/v1/models
   ```

4. **Check logs**:
   ```bash
   # On the MacBook Pro
   tail -f ~/Library/Logs/llama-server.log
   ```

### Models not loading
- First-time use downloads the model (can take 10-20 minutes for large models)
- Check: `tail -f ~/Library/Logs/llama-server.log` on MacBook Pro

### MacBook Pro is sleeping
Enable: **System Settings → Battery → Prevent automatic sleeping when display is off**

## Model Information

| Model | ID | Size | Purpose | Loaded on Startup |
|-------|----|------|---------|-------------------|
| GPT-OSS 20B | `gpt-oss-20b` | ~12 GB | Reasoning | ✅ Yes |
| Qwen3 30B | `qwen3-30b` | ~19 GB | General Chat | ❌ No |
| Qwen3 Coder 30B | `qwen3-coder-30b` | ~19 GB | Code | ❌ No |
| Gemma 3 27B | `gemma-3-27b` | ~17 GB | Multi-modal | ❌ No |

### Memory Management
- Maximum 2 models can be loaded at once
- When a 3rd model is requested, the least recently used is unloaded
- Models are cached in `~/Library/Caches/llama.cpp` on the MacBook Pro

## Performance Tips

- **For coding**: Use `qwen3-coder-30b` with temperature 0.1-0.3
- **For chat**: Use `qwen3-30b` with temperature 0.5-0.7
- **For quick tasks**: Use `gpt-oss-20b` (already loaded)

## Architecture

```
Zed (your machine)
  ↓ HTTPS (Tailscale)
MacBook Pro (bekk-mac-3262.adelie-pirate.ts.net)
  ↓
llama-server (localhost:9931)
  ↓
Models (cached in ~/Library/Caches/llama.cpp)
```

All traffic is:
- ✅ Encrypted via Tailscale
- ✅ Authenticated via Tailscale network
- ✅ Never leaves your private network
- ✅ No API key required (Tailscale handles auth)

## Files Modified

- `~/dotfiles/zed/settings.json` - Added `llama-server-macbook` provider and network permissions

## Related Files

- `~/Developer/homelab/mac/llama-server/install.sh` - Install script for llama-server
- `~/Developer/homelab/mac/llama-server/models.ini` - Model configuration
