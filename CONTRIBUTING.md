# Table of Contents
1. [General Guidelines](#general-guidelines)
2. [License](#license)
3. [Workflow Guide](#workflow-guide)
4. [Issue Report Contributions](#issue-report-contributions)
5. [Pull Request Contributions](#pull-request-contributions)
6. [Style Guide](#style-guide)
    - [Code Editor Configuration](#code-editor-configuration)
    - [General code guidlines and styling (all languages)](#general-code-guidlines-all-languages)
    - [C++](#c)
    - [Lua](#lua)
    - [SQL](#sql)
    - [Python](#python)

# General Guidelines

* By contributing to Topaz, either through issues or pull requests, you are expected to abide by the rules laid out here in this Contributing Guide.
* We do not support out-of-date clients or client modification.
* We do not support piracy of any kind. We encourage you to maintain an active retail subscription and support the game.

# License

* We operate under [GNU General Public License v3.0](https://github.com/DerpyProjectGroup/topaz/blob/topaz/LICENSE). We do not accept contributions that use other more restrictive licenses (such as AGPL3).

# Workflow Guide

* It is **always** better to come into Discord and ask a question instead of investing a lot of time in work that we're going to ask your to rewrite or split up.
* Cite your sources. This can be comments in your code, or your commit messages. Pull Request descriptions and comments will get lost over time.
* If you're commiting work on someone else's behalf, use git's `--author` argument so they get the credit they deserve.
* Make your commit messages meaningful, or amend/rebase once you're ready to push.

# Issue Report Contributions:

* If an issue involves incorrect NPCs or text, please include your client and server versions (type `/ver` and `!ver` in game)
* Unimplemented feature requests must be _retail behavior_, and adequetly cover everything about that feature which is missing.
* Fill out the templated checkboxes that are preloaded in the issue body. These allow us to diagnose your issue as efficiently as possible, and confirm that you've searched for duplicate issues or recent fixes. 

# Pull Request Contributions:

All contributions must be done through pull requests to the Topaz repository. We don't take fixes from Discord to apply ourselves. If you need help with making a pull request, there is a GitHub guide on how to do so. If you still need help after consulting the guide, you can ask for help in Discord and we will be happy to help you.

We prefer submitting early and often, over monolithic and once. If you're implementing a complex feature, please try to submit PRs as you get each smaller functional aspect working (use your best judgment on what counts as a useful PR). This way we can help make sure you're on the right track before you sink a lot of time into implementations we might want done in a different way.

Please try to leave your PR alone after submission, unless it's to fix bugs you've noticed, or if we've requested changes. If you're still pushing commits after opening the PR, it makes it hard for reviewers to know when you're "finished" and if it's "safe" to begin their reviews. If you do want to push early for reviews of your in-progress work, you can open your PR as a "draft".

After a pull request is made, if a staff member leaves feedback for you to change, you must either fix or address it for your pull request to be merged.

If you do not fill the checkboxes confirming that you've read the supporting documentation, and that you've tested your code - your PR will not be reviewed.

# Style Guide

## Code Editor Configuration

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

## General code guidlines (all languages):

* Your code should strive to be obvious and readable by the casual observer. You aren't going to be the only person who reads/debugs your code.
* Unix (LF) line ends at the end of every file. GitHub will tell you if you don't have one by putting a ⛔ symbol at the end of your file.
* Try not to exceed 120 chars width. Exceptions will occur, but try.
* 4 space indent, do not use tabs for alignment.
* Trim trailing whitespace.
* Space after starting comments (`-- Comment` and `// Comment`)
* If you agree with staff and/or your reviewers that some work in your pull request can be left as "to-do", make new issues on GitHub for your new `TODO` items and put the ID alongside the comment. The comment should also be sufficiently descriptive of what the missing work is, and why it was left out. eg. `// TODO: A Boy's Dream - PLD AF Quest 2 - Cannot be completed until fishing is implemented (GitHub Issue #12345)`

## C++
We keep a `.clang-format` file in the root of the repo, but accept it can be difficult to set up for use on _just your changes_, as opposed to entire files that you're working with that might have legacy styling you don't want to mess with.

Here are the points from `.clang-format` explained:

#### BasedOnStyle: WebKit
When in doubt, defaulting to `WebKit style with Allman braces` is _seemingly_ a safe option.

#### AccessModifierOffset: -4
```cpp
// Correct ✔️ 
class Classname
{
public:
    Classname();

private:
    int member;
}

// Wrong ❌
class Classname
{
    public:
    Classname();

    private:
    int member;
}
```

#### AllowShortFunctionsOnASingleLine: Empty
```cpp
// Correct ✔️ 
void f()
{ 
    foo(); 
}

// Wrong ❌
void f() { foo(); }
```

#### BreakBeforeBraces: Allman
Braces should _almost always_ be on a new line. 
```cpp
// Correct ✔️ 
if (x == 5)
{
    function();
}

// Wrong ❌
if (x == 5) {
    function();
}
```

#### BreakConstructorInitializers: BeforeComma & ConstructorInitializerIndentWidth: 0
```cpp
// Correct ✔️ 
Constructor(int param0, int param1)
: member0(param0)
, member1(param1)
{
}

// Wrong ❌
Constructor(int param0, int param1)
    : member0(param0), member1(param1){}
```

#### CompactNamespaces: 'false'
```cpp
// Correct ✔️ 
namespace Foo
{
    namespace Bar
    {
    }
}

// Wrong ❌
namespace Foo { namespace Bar {
}}
```

#### Cpp11BracedListStyle: 'false'
```cpp
// Correct ✔️ 
std::vector<int> x{ 1, 2, 3, 4 };

// Wrong ❌
std::vector<int> x{1, 2, 3, 4};
```

#### IndentCaseLabels: 'true'
```cpp
// Correct ✔️ 
switch(x)
{
    case 0:
    {
        break;
    }  
}

// Wrong ❌
switch(x)
{
case 0:
{
    break;
}  
}
```
* **Note**: It doesn't matter if your `break;` is inside or outside the body of your case statement - as long as it's there (if you indend it to be).

#### IndentWidth: 4
```cpp
// Correct ✔️ 
if (func())
{
    reaction();  
}

// Wrong ❌
if (func())
{
  reaction();  
}
```

#### KeepEmptyLinesAtTheStartOfBlocks: 'false'
```cpp
// Correct ✔️ 
void function(int x)
{
    doSomething(x);
}

// Wrong ❌
void function(int x)
{

    doSomething(x);
}
```

#### Language: Cpp
Yup.

#### PointerAlignment: Left
```cpp
// Correct ✔️ 
void function(CBigType* type);
void function(CBigType& type);

// Wrong ❌
void function(CBigType *type);
void function(CBigType &type);

// Wrong ❌
void function(CBigType * type);
void function(CBigType & type);
```

#### SortIncludes: 'true' & SortUsingDeclarations: 'true'
- Try to keep your `include` and `using` statements organised alphabetically, in logical blocks.

#### SpaceBeforeParens: ControlStatements
```cpp
// Correct ✔️ 
if (true)
{
    doThing();
}

// Wrong ❌
if(true)
{
    doThing();
}
```

#### Standard: Cpp11
```cpp
// Correct ✔️ 
A<A<int>>

// Wrong ❌
A<A<int> >
```

#### UseTab: Never
```cpp
// Correct ✔️
<4 spaces>

// Wrong ❌
<a tab>

// Wrong ❌
<a half-tab>
```

#### Braces Around Statements
`readability-braces-around-statements`
```cpp
// Correct ✔️ 
if (x == 5)
{
    function();
}

// Wrong ❌
if (x == 5)
    function();

// Wrong ❌
if (x == 5)
    function(21);
else
{
    function(42);
}
```

#### Breaks between consecutive conditional statements
```cpp
// Correct ✔️ 
if (thisThing())
{

}
else
{

}

if (thatThing())
{

}

// Correct ✔️ 
if (thisThing())
{

}

if (thatThing())
{

}

// Wrong ❌
if (thisThing())
{

}
else
{

}
if (thatThing())
{

}

// Wrong ❌
if (thisThing())
{

}
if (thatThing())
{

}
```

#### Casting - static_cast over C-Style
`cppcoreguidelines-pro-type-cstyle-cast`
```cpp
// Correct ✔️ 
uint32 param = static_cast<uint32>(input);

// Wrong ❌
uint32 param = (uint32)input;
```

#### Don't use static_cast to downcast: Use dynamic_cast instead
`cppcoreguidelines-pro-type-static-cast-downcast`
```cpp
// Correct ✔️ 
if (auto PChar = dynamic_cast<CCharEntity*>(baseEntity))
{
    PChar->DoSomething()
}

// Wrong ❌
auto PChar = static_cast<CCharEntity*>(baseEntity)
PChar->DoSomething()
// Wrong ❌

if (auto PChar = static_cast<CCharEntity*>(baseEntity))
{   
    // The cast is forced, so PChar will _always_ be populated here....
    PChar->DoSomething()
}
```

#### Arg/Param spacing
```cpp
// Correct ✔️ 
auto f(0, 1, 2, 3, 4, 5, 6);

// Wrong ❌
auto f(0,1,2,3,4,5,6);
```

#### Lambdas

Formatting tools have a famously difficult time with lamdas, here is an example lambda. If you're using them (lambdas, or tools), do your best!
```cpp
// Correct ✔️ 
auto isEntityAlive = [&](CBigEntity* entity) -> bool
{
    return entity->isAlive;
};

// Correct ✔️ 
static_cast<CCharEntity>(PPlayer)->ForParty([&](CBattleEntity* entity)
{
    entity->doStuff();
});

// Wrong ❌
auto isEntityAlive =
[&](CBigEntity* entity)
    {
        return entity->isAlive;
    };

// Formatting Emergencies ❓
// clang-format off
auto isEntityAlive = [&](CBigEntity* entity) -> bool
{
    return entity->isAlive;
};
// clang-format on
```
#### C++ Naming & Misc

* The STL is your friend, don't be afraid to use it.
* Be careful with `auto`, it can mask important type details.
* Be as `const` as you reasonably can.
* `UpperCamelCase` for namespaced functions and classes.
* `UPPER_SNAKE_CASE` for enums (exception for enum classes: style as classes).
* `lowerCamelCase` for everything else.

## Lua

A lot of the styling rules from the C++ guide can and should be applied to Lua code. Here are the important points to remember when styling your Lua:

####  Local vars are (almost) always preferred
```lua
-- Correct ✔️ 
local var = 0

-- Wrong ❌
var = 0
```

#### Allman Braces
```lua
-- Correct ✔️ 
local table =
{
    content = 1,
}

-- Wrong ❌
local table = {
    content = 1,
}
```
* **NOTE:** The final entry in a multi-line table should have a comma after it.

#### No parentheses unless needed to clarify order of operations
```lua
-- Correct ✔️ 
if condition1 == 1 then
    trigger()
end

-- Correct ✔️ 
if condition1 and (condition2 or condition3) then
    trigger()
end

-- Wrong ❌
if (condition1 == 1) then
    trigger()
end
```

#### No semicolons
```lua
-- Correct ✔️ 
local x = 42
trigger(42)

-- Wrong ❌
local x = 42;
trigger(42);

-- Wrong ❌
local x = 42; trigger(42);
```

#### Formatting Conditional Blocks
```lua
-- Short - Correct ✔️
if condition then
    bla()
end

-- Long or many multiple conditions - Correct ✔️
if
    condition1 and
    condition2 or
    not condition3
then
    bla()
end

-- Wrong ❌
if  condition1 then
    bla()
end

-- Wrong ❌
if condition1 and condition2 and
    not condition3 then
    bla()
end

-- Wrong ❌
if condition1 and condition2 and
    not condition3
then
    bla()
end
```

#### Placement of logical operators in long blocks
- `not` before, `and/or` after 
```lua
-- Correct ✔️
if
    condition1 and
    condition2 or
    not condition3
then
    bla()
end

-- Wrong ❌
if
    condition1
    and condition2
    or not condition3
then
    bla()
end
```

#### No excess whitespace inside of parentheses or solely for alignment
```lua
-- Correct ✔️ 
if condition1 and (condition2 or condition3) then
    trigger()
end

-- Wrong ❌
if condition1 and ( condition2 or condition3 ) then
    trigger()
end

-- Wrong ❌
if
      condition1 and 
    ( condition2 or condition3 )
then
    trigger()
end
```

#### Inline tables

**THIS IS THE ONE EXCEPTION TO THE GLOBAL NEWLINE-BRACE RULES** 
```lua
-- Correct ✔️ 
xi.func({
  entry = 1,
  entry = 2,
})

-- Wrong ❌
xi.func(
    {
        entry = 1,
        entry = 2,
    }
)
```

#### Lua Misc & Naming
* Our lua functions and members are typically `lowerCamelCased`, with few exceptions.
* Make sure you check out `scripts/globals/npc_util.lua` for useful tools and helpers.
* If you're going to cache a long table entry into a var with a shorter name, make sure that name still conveys the original meaning.
```lua
-- Correct ✔️ 
local copCurrentMission = player:getCurrentMission(xi.mission.log_id.COP)
local copMissionStatus = player:getCharVar("PromathiaStatus")
local sandyQuests = xi.quest.id.sandoria

-- Wrong ❌
local currentMission = player:getCurrentMission(xi.mission.log_id.COP)
local missionStatus = player:getCharVar("PromathiaStatus")
local quests = xi.quest.id.sandoria
```

## SQL

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
#### Commenting in SQL
Our SQL tables are big and confusing, and they are also modified by hand. It can be very helpful to leave _short_ comments on your additions and modifications to highlight what they are.

**Example**

Without a comment, this entry is not easily human-readable:

```sql
INSERT INTO `mob_droplist` VALUES (504,0,0,1000,888,340);
```

So we instead store it as:

```sql
INSERT INTO `mob_droplist` VALUES (504,0,0,1000,888,340); -- (Colossal Calamari) seashell
```

Conversely, `Combo` weaponskill doesn't need any additional comments because it has a name field:

```sql
INSERT INTO `weapon_skills` VALUES (1,'combo',0x02020000000200000000000002000000000202000000,1,5,0,16,2000,5,1,8,0,0,0,0);
```

The format of the comment isn't massively important, but it is preferred not to use ';' as a seperator in the middle of your comment. This is a little confusing, as it's the statement-terminator in SQL.

## SQL Migrations for Schema changes

* Going forward schema changes should be accompanied by a migration script.

## Python
Python is primarily used for support scripts.
#### Python Misc & Naming
* Python uses `lower_snake_case`
