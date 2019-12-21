# Githooks

Testing githooks, started with `pre-commit`, and then added script for `prepare-commit-msg`

- pre-commit: Check the commit message for spelling errors.
- pre-receive: Enforce project coding standards.
- post-commit: Email/SMS team members of a new commit.
- post-receive: Push the code to production.


## Notes

 - Good command for getting current git branch: `git branch | grep \* | cut -d' ' -f2`

 - Simple way to push current branch to origin remote repo `git push --set-upstream origin \`git branch | grep \* | cut -d' ' -f2\``

 - Started testing with git 2.14.3

 - for prepare-commit-msg, the name of file with commit message is passed with $HUSKY_GIT_PARAMS
    - e.g. `.git/COMMIT_EDITMSG` for message with standard commit inside editor
    - `.git/COMMIT_EDITMSG commit HEAD` when using --apend in commit and updating message in editor
    - `.git/COMMIT_EDITMSG message` when using -m with `git commit` 
