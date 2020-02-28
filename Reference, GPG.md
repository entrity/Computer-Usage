# GPG

## Encrypting/Decrypting

```bash
# Encrypt a file.
# If you don't enter a RECIPIENT, you will be prompted to enter one or more.
gpg -e [-r RECIPIENT] FILE
```

## Key management

```bash
# Sign a key (you know it belongs to who it claims)
gpg --edit-key ID sign

# Trust a key (without signing it)
gpg --edit-key ID trust
```
