-----------------------------------
-- lua_stylecheck Unit Tests
-----------------------------------

-- check_table_formatting()
local badTable = {
    1,
}

local goodTable = { 1 }

local goodTable2 =
{
    1,
}

-- check_parameter_padding()
local badPadding  = math.min(1,2)
local goodPadding = math.min(1, 2)

-- check_semicolon
local withSemicolon = math.min(1, 2);
local noSemicolon   = math.min(1, 2)

-- check_variable_names()
local BadCapital    = 1
local ID            = 1
local no_underscore = 1
local goodCamel     = 1

-- check_indentation()
local goodIndent1     = 1
    local goodIndent2 = 2

  local badIndent = 1

