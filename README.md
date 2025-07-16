# obsidian-auto-commit

This repository contains a script and instructions to automatically commit and push changes made to an Obsidian vault to a remote GitHub repository on a scheduled basis.

## Requirements

- `cron` (Crontab) installed and running  
- An existing Obsidian Vault tracked by Git  
- A GitHub repository associated with the vault  
- A GitHub authentication token with push permissions configured for the repository  

## Installation

1. **Clone this repository:**

```bash
git clone https://github.com/jose-augusto4339/obsidian-auto-commit.git
```

2. **Move the script to a directory in your PATH (e.g., `/usr/local/bin`):**

```bash
sudo mv obsidian-auto-commit/autocommit-obsidian.sh /usr/local/bin/
```

3. **Create an environment variable for your Obsidian vault path**  
(you can add this to your `.bashrc`, `.zshrc`, or `.profile`):

```bash
export OBSIDIAN_VAULT_PATH=/path/to/your/obsidian/vault
```

4. **Make the script executable:**

```bash
chmod +x /usr/local/bin/autocommit-obsidian.sh
```

5. **Edit your Crontab to schedule automatic commits:**

```bash
crontab -e
```

6. **Add a line to define the execution time.**  
The example below runs the script every day at **2:00 AM**:

```bash
0 2 * * * /usr/local/bin/autocommit-obsidian.sh
```

7. **Save and close the Crontab editor.**

8. **(Optional)** If the cron service is not running, start it:

```bash
sudo service cron start
```

## Notes

- Make sure your GitHub repository is properly initialized and the local repository inside your Obsidian vault is set up with a remote.
- You can test the script manually before relying on `cron` to ensure everything is working:

```bash
/usr/local/bin/autocommit-obsidian.sh
```

## License

MIT © José Augusto Ribeiro

## GitHub Authentication with Personal Access Token (for cron compatibility)

To allow the script to push changes to your Obsidian vault repository when run via `cron`, you need to authenticate using a GitHub personal access token (PAT). Here's how to set it up:

1. **Create a GitHub Personal Access Token (PAT):**
   - Go to [https://github.com/settings/tokens](https://github.com/settings/tokens)
   - Click on **"Generate new token"**
   - Select scopes:
     - `repo` (for full control of private repositories)
   - Copy and save the token securely (you won't see it again)

2. **Configure Git to use the token instead of a password:**
   - Change your repository remote URL to use HTTPS with token authentication:
     ```bash
     git remote set-url origin https://<YOUR_GITHUB_TOKEN>@github.com/<username>/<repo>.git
     ```
     Replace:
     - `<YOUR_GITHUB_TOKEN>` with the token generated above
     - `<username>` with your GitHub username
     - `<repo>` with your repository name

3. **(Optional but recommended)** Use a Git credential helper or environment variable:
   - Add this to your crontab to load your vault path and Git credentials:
     ```bash
     OBSIDIAN_VAULT_PATH=/path/to/vault
     GIT_ASKPASS=/bin/echo
     GIT_USERNAME=your-username
     GIT_PASSWORD=your-token
     ```

   - Alternatively, use a `.netrc` file:
     Create a file `~/.netrc` with:
     ```
     machine github.com
     login your-username
     password your-token
     ```
     And ensure correct permissions:
     ```bash
     chmod 600 ~/.netrc
     ```

> ⚠️ Be cautious with storing your token. Use secure methods and avoid committing the token into version control.
