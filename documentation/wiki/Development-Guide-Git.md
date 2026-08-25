# Development Guide (Git)

Git is important, it's important that you use it correctly.

-----

- [Development Guide (Git)](#development-guide-git)
  - [Writing useful commit messages](#writing-useful-commit-messages)
  - [Example of making changes (command line)](#example-of-making-changes-command-line)
  - [Amending the previous commit](#amending-the-previous-commit)
  - [Git Attribution](#git-attribution)
    - [Full Author](#full-author)
    - [Co-Author](#co-author)
  - [Other Useful Commands](#other-useful-commands)
  - [Other Guides](#other-guides)

-----

## Writing useful commit messages

When you make a commit, you're adding a collection of changes with a title describing them to the codebase. These commits and messages are being constantly read and checked against as others do work on the codebase. It is vitally important that the messages you assign to your commits are a clear representation of the work you're submitting - in the context of the entire codebase, not just your pull request!

There are no hard or fast rules for what a good commit message should look like, but it:
- Shouldn't be too short or long
- If you need to explain more, consider leaving notes in the code, or make the commit multiline
- It should describe what's changing, possibly also why - if it makes sense to mention that

For example: If your changes are adding a feature to trusts, your commit message should look like:

```txt
[trust] Allow trusts to heal themselves
```

Or multiline:

```txt
[trust] Allow trusts to heal themselves

Trusts didn't have context for how hurt they were relative to other party members. This adds a structure to the CParty* that lets them track whats going on with the rest of the party.
```

If you submit some code and we ask you to make changes to it you should ammend your previous commits rather than adding new commits to address our requests.

This is also the case if you have to make changes to your code to get it to pass our CI checks.

Some examples of **WHAT NOT TO DO**:

```txt
Update file.txt
```

```txt
Remove debug logging because maintainers asked me to
```

```txt
Align comments to pass CI
```

If (once your PR is merged) the content of your message loses all meaning - then it's a bad message.

## Example of making changes (command line)

- Before you start, make sure the editor `git` will use is set to `vim` using:
  - `git config --global core.editor "vim"`

-----

- `git status`

```ps
PS C:\ffxi\lsb-wiki> git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

- `git checkout -b`

```ps
PS C:\ffxi\lsb-wiki> git checkout -b add_new_files_for_tutorial
Switched to a new branch 'add_new_files_for_tutorial'

PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
nothing to commit, working tree clean
```

- `git status` with changes

```ps
PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        New_File.md

nothing added to commit but untracked files present (use "git add" to track)
```

- `git add`

```ps
PS C:\ffxi\lsb-wiki> git add .\New_File.md

PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   New_File.md
```

- `git commit`

```ps
PS C:\ffxi\lsb-wiki> git commit --message "Add New File for git tutorial"
[add_new_files_for_tutorial 590ed78] Add New File for git tutorial
 1 file changed, 3 insertions(+)
 create mode 100644 New_File.md

PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
nothing to commit, working tree clean
```

- `git push`

```ps
PS C:\ffxi\lsb-wiki> git push
fatal: The current branch add_new_files_for_tutorial has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin add_new_files_for_tutorial
```

- `git push --set-upstream`

```ps
PS C:\ffxi\lsb-wiki> git push --set-upstream origin add_new_files_for_tutorial
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 16 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 325 bytes | 325.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote:
remote: Create a pull request for 'add_new_files_for_tutorial' on GitHub by visiting:
remote:      https://github.com/LandSandBoat/lsb-wiki/pull/new/add_new_files_for_tutorial
remote:
To github.com:LandSandBoat/lsb-wiki.git
 * [new branch]      add_new_files_for_tutorial -> add_new_files_for_tutorial
Branch 'add_new_files_for_tutorial' set up to track remote branch 'add_new_files_for_tutorial' from 'origin'.
```

- You notice a mistake, or you're asked to make changes in your PR

```ps
PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Your branch is up to date with 'origin/add_new_files_for_tutorial'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   Home.md

no changes added to commit (use "git add" and/or "git commit -a")
```

```ps
PS C:\ffxi\lsb-wiki> git add .\Home.md

PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Your branch is up to date with 'origin/add_new_files_for_tutorial'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   Home.md
```

```ps
PS C:\ffxi\lsb-wiki> git commit --message "Forgot to add link to new file, oops!"
[add_new_files_for_tutorial 9518095] Forgot to add link to new file, oops!
 1 file changed, 4 insertions(+)

PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Your branch is ahead of 'origin/add_new_files_for_tutorial' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
```

```ps
PS C:\ffxi\lsb-wiki> git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 16 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 349 bytes | 349.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:LandSandBoat/lsb-wiki.git
   590ed78..9518095  add_new_files_for_tutorial -> add_new_files_for_tutorial

PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Your branch is up to date with 'origin/add_new_files_for_tutorial'.

nothing to commit, working tree clean
```

```ps
PS C:\ffxi\lsb-wiki> git log --oneline
9518095 (HEAD -> add_new_files_for_tutorial, origin/add_new_files_for_tutorial) Forgot to add link to new file, oops!
590ed78 Add New File for git tutorial
bcf5ad4 (origin/main, origin/HEAD, main) Merge pull request #44 from LandSandBoat/onmobdeath-optparam
ad6a6b9 Update How to Script a Mob to reflect onMobDeath optParams change
e4d3011 Merge pull request #43 from WinterSolstice8/main
...
```

- Reviewers ask you to fix your commits, since "Forgot to add link to new file, oops!" is not a great commit message
- How many commits are you going to walk back? We have 2, so we'll walk back from our current place (HEAD) to 2 commit behind (HEAD~2).

```ps
PS C:\ffxi\lsb-wiki> git rebase --interactive HEAD~2
```

- The text editor `vim` will pop up

```ps
pick 590ed78 Add New File for git tutorial
pick 9518095 Forgot to add link to new file, oops!

# Rebase bcf5ad4..9518095 onto bcf5ad4 (2 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup [-C | -c] <commit> = like "squash" but keep only the previous
#                    commit's log message, unless -C is used, in which case
#                    keep only this commit's message; -c is same as -C but
#                    opens the editor
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified); use -c <commit> to reword the commit message
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
```

- Press `i` to enter `--INSERT--` mode to make text changes.
- Change `pick` to `squash` for any commits you want to squash into the commit that preceeds them.

```ps
pick 590ed78 Add New File for git tutorial
squash 9518095 Forgot to add link to new file, oops!
```

- Press `ESC` to exit `--INSERT--` mode.
- `:w` to write the file (to save it).
- `:q` to quit vim.
- (You can also just use `:wq`)
- You'll then be prompted to rewrite your commit message (press `i` for `--INSERT--` mode again, `:wq` to save and quit)

```ps
# This is a combination of 2 commits.
# This is the 1st commit message:

Add New File for git tutorial

# This is the commit message #2:

Forgot to add link to new file, oops!

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Date:      Thu Oct 6 10:10:50 2022 +0300
#
# interactive rebase in progress; onto bcf5ad4
# Last commands done (2 commands done):
#    pick 590ed78 Add New File for git tutorial
#    squash 9518095 Forgot to add link to new file, oops!
# No commands remaining.
# You are currently rebasing branch 'add_new_files_for_tutorial' on 'bcf5ad4'.
## Changes to be committed:
#       modified:   Home.md
#       new file:   New_File.md
#
```

- Change your commit message as needed

```git
# This is a combination of 2 commits.
# This is the 1st commit message:

Add New File for git tutorial

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Date:      Thu Oct 6 10:10:50 2022 +0300
#
# interactive rebase in progress; onto bcf5ad4
# Last commands done (2 commands done):
#    pick 590ed78 Add New File for git tutorial
#    squash 9518095 Forgot to add link to new file, oops!
# No commands remaining.
# You are currently rebasing branch 'add_new_files_for_tutorial' on 'bcf5ad4'.
#
# Changes to be committed:
#       modified:   Home.md
#       new file:   New_File.md
#
```

```ps
PS C:\ffxi\lsb-wiki> git log --oneline
e00d94a (HEAD -> add_new_files_for_tutorial) Add New File for git tutorial
bcf5ad4 (origin/main, origin/HEAD, main) Merge pull request #44 from LandSandBoat/onmobdeath-optparam
```

- Now the commits on your local branch are different to the commits on your remote branch

```ps
PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Your branch and 'origin/add_new_files_for_tutorial' have diverged,
and have 1 and 2 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

nothing to commit, working tree clean
PS C:\ffxi\lsb-wiki>
```

- If you try to push, you'll be rejected because git doesn't know how you want to resolve these differences.

```ps
PS C:\ffxi\lsb-wiki> git push
To github.com:LandSandBoat/lsb-wiki.git
 ! [rejected]        add_new_files_for_tutorial -> add_new_files_for_tutorial (non-fast-forward)
error: failed to push some refs to 'github.com:LandSandBoat/lsb-wiki.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
PS C:\ffxi\lsb-wiki>
```

- You know your local branch is correct, so you can `--force` push it onto your remote, replacing the remote commits with your local commits.

```ps
PS C:\ffxi\lsb-wiki> git push --force
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 16 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (4/4), 432 bytes | 432.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:LandSandBoat/lsb-wiki.git
 + 9518095...e00d94a add_new_files_for_tutorial -> add_new_files_for_tutorial (forced update)
PS C:\ffxi\lsb-wiki>
```

## Amending the previous commit

If you've made a small mistake and need to quickly amend it, or your work is only a single commit, you can skip the full rebase process and just use `git commit --amend`.

```ps
PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Your branch is up to date with 'origin/add_new_files_for_tutorial'.

nothing to commit, working tree clean

PS C:\ffxi\lsb-wiki> git log --oneline
e00d94a (HEAD -> add_new_files_for_tutorial, origin/add_new_files_for_tutorial) Add New File for git tutorial
bcf5ad4 (origin/main, origin/HEAD, main, git_guide) Merge pull request #44 from LandSandBoat/onmobdeath-optparam
...
```

```ps
PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Your branch is up to date with 'origin/add_new_files_for_tutorial'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   New_File.md

no changes added to commit (use "git add" and/or "git commit -a")
```

```ps
PS C:\ffxi\lsb-wiki> git add .\New_File.md

PS C:\ffxi\lsb-wiki> git status
On branch add_new_files_for_tutorial
Your branch is up to date with 'origin/add_new_files_for_tutorial'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   New_File.md
```

```ps
git commit --amend
```

```ps
Add New File for git tutorial

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Date:      Thu Oct 6 10:10:50 2022 +0300
#
# On branch add_new_files_for_tutorial
# Your branch is up to date with 'origin/add_new_files_for_tutorial'.
#
# Changes to be committed:
#       modified:   Home.md
#       new file:   New_File.md
```

```ps
[add_new_files_for_tutorial 7c7869e] Add New File for git tutorial
 Date: Thu Oct 6 10:10:50 2022 +0300
 2 files changed, 9 insertions(+)
 create mode 100644 New_File.md
PS C:\ffxi\lsb-wiki>
```

- Notice that the commit hash is different for this new modified commit.

```ps
PS C:\ffxi\lsb-wiki> git log --oneline    
7c7869e (HEAD -> add_new_files_for_tutorial) Add New File for git tutorial
bcf5ad4 (origin/main, origin/HEAD, main, git_guide) Merge pull request #44 from LandSandBoat/onmobdeath-optparam
```

```ps
PS C:\ffxi\lsb-wiki> git push
To github.com:LandSandBoat/lsb-wiki.git
 ! [rejected]        add_new_files_for_tutorial -> add_new_files_for_tutorial (non-fast-forward)
error: failed to push some refs to 'github.com:LandSandBoat/lsb-wiki.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

```ps
PS C:\ffxi\lsb-wiki> git push --force
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 16 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 481 bytes | 481.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:LandSandBoat/lsb-wiki.git
 + e00d94a...7c7869e add_new_files_for_tutorial -> add_new_files_for_tutorial (forced update)
```

## Git Attribution

Everyone likes to be credited for their work. Nobody likes to have someone else claim the credit for their work (knowingly or not). For this reason, we think you should be actively trying to attribute commits to other people where relevant.

Projects come and go, patch notes will be lost over time, but the git history is forever!

You can attribute in multiple ways:

### Full Author

If you are fully taking someone else's work, and modifying it to fit your needs, you should do this as two commits:

1: Take the work as-is

2: Modify it to your needs

For commit number 1, you should commit it with: `git commit -m "Commit message" --author "Author Name <authoremail@gmail.com>"`

In this case, you will be the committer, and they will be the author.

### Co-Author

If you have been working closely with someone, and need to credit them (or you're referencing their work), you can add their information as a co-author in your commit message:

```txt
Commit title

Commit body

Co-authored-by: name <additional-dev-1@example.com>
Co-authored-by: name <additional-dev-2@example.com>
```

## Other Useful Commands

```sh
# Number of commits per author since date
git shortlog -s --since="01 Jan 2021"

# Contribution statistics since "1 year ago"
git log --shortstat --since "1 year ago" | grep "files changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print "files changed", files, "lines inserted:", inserted, "lines deleted:", deleted}'

# Count commits since date
git rev-list --count --after="Jan 1 2021" --all --no-merges
```

## Other Guides

- https://www.sitepoint.com/git-interactive-rebase-guide/
