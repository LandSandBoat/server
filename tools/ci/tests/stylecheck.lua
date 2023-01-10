-----------------------------------
-- lua_stylecheck Unit Tests
-----------------------------------

-- check_table_formatting()
local badTable = { -- FAIL
    1,
}

local badTable2 = {1 } -- FAIL
local badTable3 = { 1} -- FAIL

local goodTable = { 1 }

local goodTable2 =
{
    1,
}

-- check_parameter_padding()
local badPadding  = math.min(1,2) -- FAIL
local goodPadding = math.min(1, 2)

-- check_semicolon
local withSemicolon = math.min(1, 2); -- FAIL
local noSemicolon   = math.min(1, 2)

-- check_variable_names()
local BadCapital    = 1 -- FAIL
local ID            = 1
local no_underscore = 1 -- FAIL
local goodCamel     = 1

-- check_indentation()
local goodIndent1     = 1
    local goodIndent2 = 2

  local badIndent = 1 -- FAIL

-- check_operator_padding()
local a= 1 -- FAIL
a = 1+1    -- FAIL
a = 1*1    -- FAIL
a = 1/1    -- FAIL

local b =2 -- FAIL

if b ==a then -- FAIL
end

if b== a then -- FAIL
end

if b~= a then -- FAIL
end

if a ==b then -- FAIL
end

if a>=b then -- FAIL (x2)
end

if a <=b then -- FAIL
end

if a>b then -- FAIL
end

if a< b then -- FAIL
end

if a == b then
end

local c = 5

-- check_newline_after_end()
if a == b then
end  -- FAIL
if b == c then
end

-- check_no_newline_after_function_decl()
local function badFunction() -- FAIL

    return 1
end

-- check_no_newline_before_end()
local function badFunction2()
    return 1

end -- FAIL

local function goodFunction()
    return 1
end

-- check_no_single_line_functions()
local function badFunction3() return 1 end -- FAIL (x2)

-- check_no_single_line_conditions()
if a == b then a = 5 end -- FAIL

-- check_no_function_decl_padding()
local function test (var1)
end

-- check_multiline_condition_format()
if a == b or -- FAIL
    a == c then -- FAIL
end

if a == b or b == c -- FAIL
then
end

if
a == b then -- FAIL
end

-- No outer parens in conditions
if (a == b) then -- FAIL
end

if
    ((a == b) or
    (b == c)) -- FAIL
then
end

-- No explicit boolean checks in conditions
if b == true then -- FAIL
end

-- Multiline checks
if
    a == b or not -- FAIL
    b
then
end

if
    not a == b
    or b == c -- FAIL
then
end

if
    a == b
    and b == c -- FAIL
then
end

if
    a== b or -- FAIL
    c ~=a    -- FAIL
then
end

if
    not a == b or
    b == c and
    a == c
then
end

-- Long single-line condition
local reallyLongVariableNameOne = 1
local reallyLongVariableNameTwo = 2

if reallyLongVariableNameOne == reallyLongVariableNameTwo and reallyLongVariableNameTwo - reallyLongVariableNameOne == 0 then -- FAIL
end
