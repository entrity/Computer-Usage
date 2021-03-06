# GPG

## Encrypting/Decrypting

```bash
# Encrypt a file. If you don't enter a RECIPIENT, you will be prompted to enter one or more.
gpg -e [-r RECIPIENT] FILE
# Encrypt a file using a passphrase
gpg -c # Alias gpg --symmetric
```

## Key management

### Sign, trust
```bash
# Sign a key (you know it belongs to who it claims)
gpg --edit-key ID sign

# Trust a key (without signing it)
gpg --edit-key ID trust
# One-liner
echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key ID trust
```

### Import, export
```bash
# Export an ascii-armored key
gpg --export -a ID > public.key

# Export a private key
gpg --export-secret-key -a ID > private.key

# Import a key
gpg --import public.key
```

### Create, delete
```bash
# Create key
gpg --gen-key
# Delete public key
gpg --delete-key ID
# Delete secret key
gpg --delete-secret-key ID
```
