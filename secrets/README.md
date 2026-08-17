# Encrypted secrets

This directory contains encrypted SOPS files only. Never commit plaintext tokens or
private age keys.

## One-time setup on each host

After rebuilding the configuration, create a host-specific age identity:

```bash
install -d -m 0700 ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
chmod 0600 ~/.config/sops/age/keys.txt
age-keygen -y ~/.config/sops/age/keys.txt
```

Copy each printed `age1...` public key into `.sops.yaml` (start from
`.sops.yaml.example`). Keep both recipients so either host can decrypt the same
encrypted secret.

## GitHub token

Create a fine-grained GitHub token with only the repositories and permissions it
needs, and give it an expiry. Create the encrypted secret locally:

```bash
mkdir -p secrets
sops secrets/github.yaml
```

Enter this structure in the editor, then save:

```yaml
github_token: YOUR_TOKEN_GOES_HERE
```

Commit the encrypted `secrets/github.yaml` and the completed `.sops.yaml`, then
rebuild. The secret will be available only at `/run/secrets/github-token` with
permissions `0400` for user `buber`.

For an interactive command, read the file only for that process:

```bash
GITHUB_TOKEN="$(< /run/secrets/github-token)" your-command
```
