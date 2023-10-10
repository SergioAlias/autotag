# Autotag
`autotag.sh` is a Bash script for Git auto-tagging. The script adds a [Semmantic Versioning accurate](https://semver.org/) tag after a commit/push to a Git repository. It also uses the last commit message as the tag message.

## Usage

You need to use it after a `git commit` as follows:

```bash
git commit -m "Some changes"
```
```bash
git push
```

```bash
./autotag.sh
```

Supposing the script is in you working directory (see below for adding it to the PATH). This will add a tag `v1.0.0` (if there are no tags) or it will add one to the last number i.e. PATCH version (`v1.0.1`, `v1.0.2`, etc).

For upgrading the second number (MINOR version) you need to specify the `-2` flag:

```bash
./autotag.sh -2
```

This will add one to the MINOR version and set to zero the PATCH version (e.g. from `v1.0.2` to `v1.1.0`).

For upgrading the first number (MAJOR version) use the `-1` flag:


```bash
./autotag.sh -1
```

This will add one to the MAJOR version and set to zero the MINOR and PATCH version (e.g. from `v1.3.5` to `v2.0.0`).

## How it works

This script uses the `git describe` command to get the last tag in the repository, if any. If there is no tag, it assumes this is the first commit and sets the tag to `v1.0.0`. Otherwise, it parses the last tag using Bash string manipulation, increments the relevant part depending on the argument passed to the script (or defaults to incrementing PATCH version), and constructs the new tag using string concatenation.

The script then uses the `git log` command with the `--pretty=%B` option to get the last commit message. It creates a new annotated tag with the git tag command, using the `-a` option to specify the tag name and the `-m` option to add the message to the tag. Finally, it pushes the new tag to the remote repository with the `git push` command and the `--tags` option.

## Adding the script to the PATH

We suppose you work on a Linux or macOS system because you dont want [viruses](https://es.wikipedia.org/wiki/Microsoft_Windows) in your machine. Adding `autotag.sh` to the PATH will allow you to execute it anywhere as simple as:

```bash
autotag.sh
```
### I have root permissions

1. Move your script to a directory that is already in your PATH, such as `/usr/local/bin`. You can do this with the `mv` command:
   ```bash
   sudo mv autotag.sh /usr/local/bin/
   ```
   
2. Make your script executable using the `chmod` command:
   ```bash
   sudo chmod +x /usr/local/bin/autotag.sh
   ```

3. Verify that your script is in the path by running:
   ```bash
   echo $PATH
   ```
   This will print a list of directories separated by colons. Make sure that `/usr/local/bin` is included in this list.

Now you should be able to run your script from anywhere by simply typing `autotag.sh` in the terminal. You may need to open a new terminal window for the changes to take effect.

### I do NOT have root permissions

If you are working on your institution's machine and you don't have root permissions (it happens all the time), you can do it as follows:

1. Create a `bin` directory in your home directory, if it doesn't exist already:
   ```bash
   mkdir -p ~/bin
   ```

2. Move your script to the `bin` directory:
   ```bash
   mv autotag.sh ~/bin/
   ```

3. Make your script executable:
   ```bash
   chmod +x ~/bin/autotag.sh
   ```

4. Add the `bin` directory to your PATH environment variable by adding the following line to your `.bashrc` or `.bash_profile` file in your home directory:
   ```bash
   export PATH="$HOME/bin:$PATH"
   ```

5. Reload your shell environment by either opening a new terminal window or running the following command:
   ```bash
   source ~/.bashrc
   ```

Now you should be able to run your script from anywhere by simply typing `autotag.sh` in the terminal.
