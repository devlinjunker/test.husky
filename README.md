# Githooks

Testing githooks, started with `pre-commit`, and then added script for `prepare-commit-msg`

- commit-msg: Check the commit message after modified (e.g. spelling errors,match standard)
- pre-receive: (on Remote Repo) Enforce project coding standards
- pre-commit: (Before Commit message) used to verify standards before committing
- post-commit: (After commit) Email/SMS team members of a new commit
- post-receive: (on Remote Repo) Push the code to production
- prepare-commit-message: help generate the commit message
- post-checkout: called after checking out or clone (can be used to verify or display current details)

## Notes

 - Good command for getting current git branch: `git branch | grep \* | cut -d' ' -f2`

 - Simple way to push current branch to origin remote repo `git push --set-upstream origin \`git branch | grep \* | cut -d' ' -f2\``

 - Started testing with git 2.14.3

 - for prepare-commit-msg, the name of file with commit message is passed with $HUSKY_GIT_PARAMS (1st is file with commit message, second is method of creating message, third is revision number)
    - e.g. `.git/COMMIT_EDITMSG` for message with standard commit inside editor
    - `.git/COMMIT_EDITMSG commit HEAD` when using --apend in commit and updating message in editor
    - `.git/COMMIT_EDITMSG message` when using -m with `git commit` 

 - githooks environment variables
  - https://longair.net/blog/2011/04/09/missing-git-hooks-documentation/


## Ideas
 - Github action to label PRs based on the branch name: https://github.com/TimonVS/pr-labeler-action
    - feature/ or feat/
    - fix/
    - chore/

 - Templates
    - commit.template config in repo to reference commit message template
    - Github PR template
    - Github Issue template

 - Before all Commits:
    - Lint
    - Compile
    - don't allow commits with -m option

 - Commit Message Template?

 - After Commit Message:
    - Verify message contains title and description

 - On Release branch commit? (release/X.XX)
    - increment patch version number and create tag after incremented 

 - On master commit 
    - Lint/Compile
    - Run Tests (not on feature/fix/chore branch?)
    - update docs
    - check for spec files (unless code file has header with `ignore-spec` command)
    - check for READMEs in directories

 - Github Branch protections: https://help.github.com/en/github/administering-a-repository/enabling-branch-restrictions
    - no commits to master
    - local git hook on pre-push to prevent push to master

 - Remote Server with git repo can handle deployment
    - add git remote for environment
    - on receiving new branch or updated commit, can switch to that version and build production app

 - Github Actions:
    - https://help.github.com/en/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows
    - Ideas: Creation of tags or branches on github
    - On PR: Run Master commit check 
    - on push to github branch
    - on release (different activity `types` for different actions, e.g. created, published..)
    - scheduled event
