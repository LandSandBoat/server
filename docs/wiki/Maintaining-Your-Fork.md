If you plan to run your own server using the LSB codebase, you'll want your own copy of the code repository. The best way to achieve this is to **fork**.

### Creating your fork

GitHub provides an easy to use button in the top right of the front page of any repo, allowing you to create a full copy of the repo from that point in time. This copy will include all of the commit history and changes up to that point. This is important because your fork will have a **shared history** with the LSB codebase. This will allow you to easily cherry-pick code, or pull in feature branches from LSB. 

### Git Pull

### Cherry-Picking
The command `git cherry-pick <commit>` applies the changes introduced by the named commit on the current branch. It will introduce a new, distinct commit. Strictly speaking, using `git cherry-pick` doesn’t alter the existing history within a repository; instead, it adds to the history. As with other Git operations that introduce changes via the process of applying a diff, you may need to resolve conflicts to fully apply the changes from the given commit. The command git cherry-pick is typically used to introduce particular commits from one branch within a repository onto a different branch. A common use is to forward- or back-port commits from a maintenance branch to a development branch.

### Defensive Design
If you plan on making heavy modifications to the LSB codebase while still receiving changes from it, you will likely want to employ some *defensive design* techniques to make sure your changes are not overwritten by the incoming LSB changes.

- **Keep changes in separate files.** If you replace a function call with your own that you keep in its own file, you will have less possible sources of collision. If you keep your SQL changes in a file that is applied after the regular LSB update, you never have to resolve conflicts.

- **Use modules!** In keeping with the above, anything in a module is in its own file, safely self contained. This will save you many hassles, as modules were designed for exactly the purpose of letting you change things without having to edit the stock files!

- **Block comments.** If you employ `/* block */, --[[ block ]]` comment style around large blocks you are commenting out, you will only have to resolve changes on two lines, rather than the entire block in question.

- **Mark your custom changes so they are easy to spot.** Marking a block with `// Custom server X's stat calculations` will make sure it's very easy to spot and maintain when you're resolving conflicts.

- **Namespacing.** If you're replacing logic in specific function calls, you could keep your custom work in a namespace. `NewServer::GetRandomNumber()` is very clearly specific to your server.

### Dangers of Copy/Pasting
- At some point, copy pasta ***WILL*** break things. Often in way you can neither predict nor discern was the cause.

### Understanding the LSB License
It is GPL3 and nothing else. This means:

- You _cannot_ re-license existing code to not be GPL3.
- New things derived from existing code is _also_ GPL3.
- You _can_ link to non GPL code, if that code has a comparable license (like MIT).
- You _cannot_ hold the author(s) liable for damages related to your use of the code.
- If you distribute, you have to also share the source and license.
- Everyone has the right to copy modify and distribute. This is non-revocable; nobody can "take their ball and go home" once its been shared.

https://tldrlegal.com/license/gnu-general-public-license-v3-(gpl-3)
