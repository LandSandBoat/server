# Issue Report Contributions:

* If an issue involves incorrect NPCs or text, please include your client version (type `/ver` in game)
* Unimplemented feature requests must be _retail behavior_, and adequetly cover everything about that feature which is missing.

----

# Pull Request Contributions:

**By submitting a pull request to Project Topaz, you agree to our [Limited Contributor License Agreement](http://project-topaz.com/blob/release/CONTRIBUTOR_AGREEMENT.md)**

All contributions must be done through pull requests to the Topaz repository.  We don't take fixes from Discord to apply ourselves.  If you need help with making a pull request, there is a GitHub guide on how to do so.  If you still need help after consulting the guide, you can ask for help in Discord and we will be happy to help you.

We prefer submitting early and often, over monolithic and once. If you're implementing a complex feature, please try to submit PRs as you get each smaller functional aspect working (use your best judgment on what counts as a useful PR). This way we can help make sure you're on the right track before you sink a lot of time into implementations we might want done in a different way.

Please try to leave your PR alone after submission, unless it's to fix bugs you've noticed, or if we've requested changes. If you're still pushing commits after opening the PR, it makes it hard for reviewers to know when you're "finished" and if it's "safe" to begin their reviews.

After a pull request is made, if a staff member leaves feedback for you to change, you must either fix or address it for your pull request to be merged.

# Style Guide

### Code Editor Configuration

Much of this can be automated. 

We highly recommend [editorconfig](http://editorconfig.org/#download), which most code editors have either a plugin or native support for.
* [Visual Studio Plugin](https://github.com/editorconfig/editorconfig-visualstudio#readme)
* [Notepad++](https://github.com/editorconfig/editorconfig-notepad-plus-plus#readme)
  * As the plugin manager is usually installed by default\*, the easy way is to use that:
  Launch Notepad++, click on the `Plugins` menu, then `Plugin Manager` -> `Show Plugin Manager`. In the `Available` tab, find `EditorConfig` in the list, check the checkbox and click on the `Install` button.
    * \*64bit may require manual installation.
* [Sublime](https://github.com/sindresorhus/editorconfig-sublime#readme): Install EditorConfig with Package Control and restart Sublime.
* [Vim](https://github.com/editorconfig/editorconfig-vim#readme)

Clang-Format is also an option for C++
* [Visual Studio plugin](https://marketplace.visualstudio.com/items?itemName=LLVMExtensions.ClangFormat)
* [Visual Studio Code plugin](https://marketplace.visualstudio.com/items?itemName=xaver.clang-format)

### General code guidlines (all languages):

* Try not to exceed 120 chars width. Exceptions will occur, but try.
* 4 space indent (death to tabs)
* No using tabs for alignment either.
* Trim trailing whitespace.

### C++

* Unix (LF) line ends
* Braces go on a newline unless it's a lambda or empty ([allman](https://en.wikipedia.org/wiki/Indent_style#Allman_style) style)
* Space between keyword and parentheses
* No using tabs for alignment
* UpperCamelCase for namespaced functions and classes
* UPPER_SNAKE_CASE for ENUM (exception for enum classes: style as classes)
* Asterisk goes up against the type, not the value. We want:
  ```
  Foo* Bar
  ```
  not:
  ```
  Foo *Bar
  ```
  and *definitely* not:
  ```
  Foo * Bar
  ```

### Lua

* Unix (LF) line ends
* Curly braces go on a newline unless empty, or opening a lambda.
* Our lua functions are typically lowerCamelCased, with few exceptions (just FYI).
* No parentheses unless needed to clarify order of operations.
* No semicolons unless multiple statements on a single line.
* No excess whitespace inside of parentheses solely for alignment.
* *When* aligning (not always needed), it is preferred to do so like this:
  ```lua
  variable  = thing
  variable2 = thing2
  ```
  not like this:
  ```
  variable1 = thing1
   variable = thing
  ```
  and definitely not like this:
  ```
  if  variable == thing  then
  if variable2 == thing2 then
  ```
  
* Large if statements should be broken up like so:
```lua
-- Short
if condition then
    bla
end

-- Long or many multiple conditions:
if
    condition and
    condition or
    condition
then
    stuff
end
```

### SQL

* Don't put single quotes around non string fields:
  ```
  42,0
  ```
  not:
  ```
  '42','0'
  ```

* No line breaks in the middle of a statement:
  ```
  INSERT INTO table_name (a,b,c,x,y,z);
  ```
  not:
  ```
  INSERT INTO table_name (a,b,c,
  x,y,z);
  ```
* Spaces in names get replaced with an underscore. Hyphens are allowed. Most other symbols are removed from item/mob/npc names *except* for polutils_name or packet_name columns, where they must be escaped.
* Full lower case skill/spell/pet/ability things.
* Don't change SQL keywords to lowercase:
  ```
  INSERT INTO table_name
  ```
  not:
  ```
  insert into table_name
  ```

  #### SQL Migrations for Schema changes

  * Going forward schema changes should be accompanied by a migration script.
