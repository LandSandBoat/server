# <a id="table-of-contents"/>Table of Contents

- [AI, LLMs, etc.](#ai)
- [C++](#c)
- [Lua](#lua)
- [SQL](#sql)
- [Python](#python)
- [Git](Development-Guide-Git)

## <a id="contributing"/>Contributing

It is assumed you've read the [Contributing Guide](https://github.com/LandSandBoat/server/blob/base/CONTRIBUTING.md).

## <a id="c"/>C++

### <a id="c-naming-misc"/>Naming & Misc

- The STL is your friend, don't be afraid to use it.
- Be careful with `auto`, it can mask important type details.
- Be as `const` as you reasonably can.
- `UpperCamelCase` for namespaced functions and classes.
- `UPPER_SNAKE_CASE` for enums (exception for enum classes: style as classes).
- `lowerCamelCase` for everything else.
- You should use exceptions only in exceptional circumstances:
  - If player/server data is at risk of being lost or corrupted, this is probably a good time to throw an exception and take down the server.
  - If you're encountering a situation that shouldn't ever be happening, best to kill it with an exception.
  - (Begrudgingly) If the STL, a third party lib, or legacy code relies on throwing exceptions as part of regular operation (LuaJIT does this) - wrap them in try/catch and move on with your life.

### <a id="c-styling"/>Styling

We keep a `.clang-format` file in the root of the repo, but accept it can be difficult to set up for use on _just your changes_, as opposed to entire files that you're working with that might have legacy styling you don't want to mess with.

Here are the points from `.clang-format` explained:

#### <a id="c-basedonstyle"/>BasedOnStyle: WebKit

When in doubt, defaulting to `WebKit style with Allman braces` is _seemingly_ a safe option.

#### <a id="c-accessmodifieroffset"/>AccessModifierOffset: -4

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

#### <a id="c-allowshortfunctionsonasingleline"/>AllowShortFunctionsOnASingleLine: Empty

```cpp
// Correct ✔️ 
void f()
{ 
    foo(); 
}

// Wrong ❌
void f() { foo(); }
```

#### <a id="c-breakbeforebraces"/>BreakBeforeBraces: Allman

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

#### <a id="c-breakconstructorinitializers-constructorinitializerindentwidth"/>BreakConstructorInitializers: BeforeComma & ConstructorInitializerIndentWidth: 0

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

#### <a id="c-compactnamespaces"/>CompactNamespaces: 'false'

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

#### <a id="c-cpp11bracedliststyle"/>Cpp11BracedListStyle: 'false'

```cpp
// Correct ✔️ 
std::vector<int> x{ 1, 2, 3, 4 };

// Wrong ❌
std::vector<int> x{1, 2, 3, 4};
```

#### <a id="c-indentcaselabels"/>IndentCaseLabels: 'true'

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

- **Note**: It doesn't matter if your `break;` is inside or outside the body of your case statement - as long as it's there (if you indend it to be).

#### <a id="c-indentwidth"/>IndentWidth: 4

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

#### <a id="c-keepemptylinesatthestartofblocks"/>KeepEmptyLinesAtTheStartOfBlocks: 'false'

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

#### <a id="c-language"/>Language: Cpp

Yup.

#### <a id="c-pointeralignment"/>PointerAlignment: Left

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

#### <a id="c-sortincludes-sortusingdeclarations"/>SortIncludes: 'true' & SortUsingDeclarations: 'true'

- Try to keep your `include` and `using` statements organised alphabetically, in logical blocks.

#### <a id="c-spacebeforeparens"/>SpaceBeforeParens: ControlStatements

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

#### <a id="c-standard"/>Standard: Cpp11

```cpp
// Correct ✔️ 
A<A<int>>

// Wrong ❌
A<A<int> >
```

#### <a id="c-usetab"/>UseTab: Never

```cpp
// Correct ✔️
<4 spaces>

// Wrong ❌
<a tab>

// Wrong ❌
<a half-tab>
```

#### <a id="c-braces-around-statements"/>Braces Around Statements

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

#### <a id="c-breaks-between-consecutive-conditional-statements"/>Breaks between consecutive conditional statements

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

#### <a id="c-breaks-to-split-wide-conditional-lines-after-the-operator"/>Breaks to split wide conditional lines - after the operator

- There is no hard rule about how wide is too wide at this time.
- Use your best judgement, but nobody likes left/right scrolling.

```cpp
// Correct ✔️
if (lotsOfStuff &&
    evenMoreStuff &&
    evenMoreStuff &&
    evenMoreStuff &&
    evenMoreStuff &&
    evenMoreStuff)
{

}

// Wrong ❌
if (lotsOfStuff
    && evenMoreStuff
    && evenMoreStuff
    && evenMoreStuff
    && evenMoreStuff
    && evenMoreStuff)
{

}

// Wrong ❌ (this is 102 chars wide)
if (lotsOfStuff && evenMoreStuff && evenMoreStuff && evenMoreStuff && evenMoreStuff && evenMoreStuff)
{

}
```

#### <a id="c-casting-static-cast-over-c-style"/>Casting - static_cast over C-Style

`cppcoreguidelines-pro-type-cstyle-cast`

```cpp
// Correct ✔️ 
uint32 param = static_cast<uint32>(input);

// Wrong ❌
uint32 param = (uint32)input;
```

#### <a id="c-dont-use-static-cast-to-downcast"/>Don't use static_cast to downcast: Use dynamic_cast instead

`cppcoreguidelines-pro-type-static-cast-downcast`

**NOTE**: There is a good reason for this. If you use `static_cast` and it fails, the returned pointer will **NOT NECESSARILY** be `nullptr` and any blocks checking against for `nullptr` might incorrectly succeed. `dynamic_cast` will return a `nullptr` if it fails.

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

#### <a id="c-arg-param-spacing"/>Arg/Param spacing

```cpp
// Correct ✔️ 
auto f(0, 1, 2, 3, 4, 5, 6);

// Wrong ❌
auto f(0,1,2,3,4,5,6);
```

#### <a id="c-lambdas"/>Lambdas

Formatting tools have a famously difficult time with lamdas, so we tend to wrap them in `// clang-format on/off` to ensure we can format them how we'd like.

```cpp
// Correct ✔️ 
// clang-format off
auto isEntityAlive = [&](CBigEntity* entity) -> bool
{
    return entity->isAlive;
};
// clang-format on

// Correct ✔️ 
// clang-format off
static_cast<CCharEntity>(PPlayer)->ForParty([&](CBattleEntity* entity)
{
    entity->doStuff();
});
// clang-format off

// Wrong ❌
auto isEntityAlive =
[&](CBigEntity* entity)
    {
        return entity->isAlive;
    };
```

[Back to Top](#table-of-contents)

## <a id="lua"/>Lua

A lot of the styling rules from the C++ guide can and should be applied to Lua code. Here are the important points to remember when styling your Lua:

### <a id="lua-naming-and-misc"/>Naming and Misc

- Our lua functions and members are typically `lowerCamelCased`, with few exceptions.
- Make sure you check out `scripts/globals/npc_util.lua` for useful tools and helpers.
- If you're going to cache a long table entry into a var with a shorter name, make sure that name still conveys the original meaning.

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

### <a id="lua-local-vars-are-almost-always-preferred"/>Local vars are (almost) always preferred

```lua
-- Correct ✔️ 
local var = 0

-- Wrong ❌
var = 0
```

### <a id="lua-table-formatting"/>Table Formatting

```lua
-- Correct (Allman style for multi-line tables) ✔️ 
local table =
{
    one = 1,
    two = 2,
}

-- Correct (Oneliner style for small, single-line tables) ✔️ 
local table = { 1, 2, 3, 4 }

-- Wrong ❌
local table = {
    content = 1,
}

-- Wrong ❌
local table =
{ one = 1,
    two = 2,
}
```

**NOTE:** The final entry in a multi-line table should have a comma after it.

### <a id="lua-no-parentheses-unless-needed-to-clarify-order-of-operations"/>No parentheses unless needed to clarify order of operations

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

### <a id="lua-no-semicolons"/>No semicolons

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

### <a id="lua-formatting-conditional-blocks"/>Formatting Conditional Blocks

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

### <a id="lua-placement-of-logical-operators-in-long-blocks"/>Placement of logical operators in long blocks

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

### <a id="lua-no-excess-whitespace"/>No excess whitespace inside of parentheses or solely for alignment

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

### <a id="lua-no-whitespace-between-function-name-and-parameters-space-between-parameters"/>No whitespace between function name and parameters; Space between parameters

```lua
-- Correct ✔️
local function myFunction(param1, param2, param3)
end

-- Wrong ❌
local function myFunction (param1,param2,param3)
end
```

### <a id="lua-logical-and-mathematical-operators-should-have-one-space-padding"/>Logical and mathematical operators should have one space padding

```lua
-- Correct ✔️
if a == b then
    a = b + c
end

-- Wrong ❌
if a==b then
    a = b+c
end
```

### <a id="lua-code-following-end-on-same-indentation-level-should-have-a-newline-inbetween"/>Code following `end` on same indentation level should have a newline inbetween

```lua
-- Correct ✔️
if a == b then
    a = b + c
end

return a

-- Wrong ❌
if a == b then
    a = b + c
end
return a
```

### <a id="lua-no-empty-newlines-after-function-declaration-or-prior-to-end"/>No empty newlines after function declaration, or prior to end

```lua
-- Correct ✔️
local function myFunction(param1, param2, param3)
    return param1 + param2
end

-- Wrong ❌
local function myFunction(param1, param2, param3)

    return param1 + param2
end

local function myFunction(param1, param2, param3)
    return param1 + param2

end
```

### <a id="lua-no-single-line-functions-or-conditions"/>No single-line functions or conditions

```lua
-- Correct ✔️
if a == b then
    a = b + c
end

local function myFunction(param1, param2, param3)
    return param1 + param2
end

-- Wrong ❌
if a == b then a = b + c end

local function myFunction(param1, param2, param3) return param1 + param2 end
```

#### <a id="lua-inline-tables"/>Inline tables

##### <a id="lua-this-is-the-one-exception-to-the-global-newline-brace-rules"/>THIS IS THE ONE EXCEPTION TO THE GLOBAL NEWLINE-BRACE RULES

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

[Back to Top](#table-of-contents)

## <a id="sql"/>SQL

- Don't put single quotes around non string fields:

  ```sql
  42,0
  ```

  not:

  ```sql
  '42','0'
  ```

- No line breaks in the middle of a statement:

  ```sql
  INSERT INTO table_name VALUES (a,b,c,x,y,z);
  ```

  not:

  ```sql
  INSERT INTO table_name VALUES (a,b,c,
  x,y,z);
  ```

- Spaces in names get replaced with an underscore. Hyphens are allowed. Most other symbols are removed from item/mob/npc names _except_ for polutils_name or packet_name columns, where they must be escaped.
- Full lower case skill/spell/pet/ability things.
- Don't change SQL keywords to lowercase:

  ```sql
  INSERT INTO table_name
  ```

  not:

  ```sql
  insert into table_name
  ```

### <a id="sql-commenting-in-sql"/>Commenting in SQL

Our SQL tables are big and confusing, and they are also modified by hand. It can be very helpful to leave _short_ comments on your additions and modifications to highlight what they are.

#### <a id="sql-example"/>Example

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

### <a id="sql-placeholder-data-in-table-rows"/>Placeholder Data in table rows

In general, it is preferred to comment out the entire row rather than only leaving a comment about still needing to capture it. Examples include item and NPC models. Use your best judgment and if you aren't sure you can always ask.

- If it "works" there is an unfortunate chance nobody will come back to finish it later, including the original author. Life happens, people come and go, take breaks etc.
- If its "wrong" we're likely to still get issue reports on it **because** of that partial implementation, more so than if it were completely missing.
- Experience has shown people don't often read those comments before complaining that "we" got it wrong.
- By having the partial data but commenting it out, it remains obviously incomplete and the next editor can more easily see what needs to happen.
- Example:

```sql
-- Missing model, looks like a fish. Just kidding this doesn't exist and is only a made up example
-- INSERT INTO `item_equipment` VALUES (65534,'holy_moly_mace',43,0,1048645,???,0,0,3,0,0);
```

**_And absolutely never substitute item modifiers!_**

### <a id="sql-sql-migrations-for-schema-changes"/>SQL Migrations for Schema changes

- Going forward schema changes should be accompanied by a migration script.

[Back to Top](#table-of-contents)

## <a id="python"/>Python

Python is primarily used for support scripts.

### <a id="python-naming-and-misc"/>Naming and Misc

- Python uses `lower_snake_case`

[Back to Top](#table-of-contents)
