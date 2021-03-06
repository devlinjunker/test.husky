# Githooks

Testing githooks, started with `pre-commit`, and then added script for `prepare-commit-msg`

- commit-msg: Check the commit message after modified (e.g. spelling errors,match standard)
- pre-receive: (on Remote Repo) Enforce project coding standards
- pre-commit: (Before Commit message) used to verify standards before committing
- post-commit: (After commit) Email/SMS team members of a new commit
- post-receive: (on Remote Repo) Push the code to production
- prepare-commit-message: help generate the commit message
- post-checkout: called after checking out or clone (can be used to verify or display current details)
- pre-merge-commit: called prior to merge commit, invoked by git merge (TODO: look into params) (used to prevent merge if desired)

## Notes

 - `npm version <major|minor|patch>` in clean working directory will update package.json and create git commit and tag with version

 - Good command for getting current git branch: `git branch | grep \* | cut -d' ' -f2`

 - Simple way to push current branch to origin remote repo `git push --set-upstream origin \`git branch | grep \* | cut -d' ' -f2\``

 - Started testing with git 2.14.3

 - for prepare-commit-msg, the name of file with commit message is passed with $HUSKY_GIT_PARAMS (1st is file with commit message, second is method of creating message, third is revision number)
    - e.g. `.git/COMMIT_EDITMSG` for message with standard commit inside editor
    - `.git/COMMIT_EDITMSG commit HEAD` when using --apend in commit and updating message in editor
    - `.git/COMMIT_EDITMSG message` when using -m with `git commit` 

 - githooks environment variables
    - https://longair.net/blog/2011/04/09/missing-git-hooks-documentation/

 - Linear Git History
   - https://www.bitsnbites.eu/a-tidy-linear-git-history/
   - shouldn't merge from master (TODO: create githook that prevents this?)
   - Git action that checks PRs to be rebased off most recent master
   - more important when multiple contributors on a project

 - Setting up branch protections
    - https://github.com/devlinjunker/test.husky/settings/branches to add rules
    - set up `master` rule for now
      - Require pull request reviews before merging
      - Require status checks to pass before merging
        - Require branches to be up to date before merging
      - Require linear history
      - Include Administrators (for now at least for testing)

## Ideas
 - Github action to label PRs based on the branch name: https://github.com/TimonVS/pr-labeler-action
    - feature/ or feat/
    - fix/
    - chore/
    - IDEAS:
      - refactor(component) ?
      - doc ?
      - poc ? - proof of concept

 - Templates [done]
    - commit.template config in repo to reference commit message template
      - wip/feature/fix/refactor(component)/doc - look into other options in angular style
    - Github PR template
    - Github Issue template
      - These are a github specific thing that needs to be managed on there
      - https://github.com/devlinjunker/test.husky/issues/templates/edit
 - Before all Commits:
    - Lint
    - Compile
    - ~~Don't allow commits with -m option?~~
      - or verify ~~request~~ type if not present? (fix/feat/refactor/wip?)
 
 - Branch specific .git_ignores (maybe even prefix based?)
    - https://gist.github.com/wizioo/c89847c7894ede628071

 - After Commit Message:
    - Verify message contains component above and 5+ words
    - TODO: spell check?
    - don't test on wip?

 - After non-master/release commit
    - check up to date with master and encourage rebase

 - On Release branch commit? (release/X.XX)
    - increment patch version number and create tag after incremented 

 - On master commit 
    - Lint/Compile
    - Run Tests (not on feature/fix/chore branch?)
    - update docs
    - check for spec files (unless code file has header with `ignore-spec` command)
    - check for READMEs in directories
    - semantic versioning based on git logs/merges to master? this is helpful for ci/cd I think
      - Q: tagging each time?
      - Q: what about -SNAPSHOT versioning?

 - Github Branch protections: https://help.github.com/en/github/administering-a-repository/enabling-branch-restrictions
    - no commits to master
    - local git hook on pre-push to prevent push to master
      - create branch for PR at commit and revert master 
      - ask type (fix/feat/refactor)

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
