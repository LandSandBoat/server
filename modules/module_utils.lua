-----------------------------------
-- Module helpers
-----------------------------------
require("scripts/globals/utils")
-----------------------------------

-- Global, for use in C++
function applyOverride(base_table, name, func)
    local old = base_table[name]
    local thisenv = getfenv(old)

    local env = { super = old }
    setmetatable(env, { __index = thisenv })

    setfenv(func, env)
    base_table[name] = func
end

-- Override Object
Override = {}
Override.__index = Override

function Override:new(target_func_str, new_func)
    local obj = {}
    setmetatable(obj, self)

    obj.name = target_func_str
    obj.func = new_func

    return obj
end

-- Module Object
Module = {}
Module.__index = Module

function Module:new(name)
    if name == nil or string.len(name) < 5 then
        printf("Invalid module name: %s", name)
    end

    local obj = {}
    setmetatable(obj, self)

    obj.name = name
    obj.overrides = {}
    obj.enabled = false

    return obj
end

function Module:setEnabled(isEnabled)
    self.enabled = isEnabled
end

function Module:addOverride(target_func_str, func)
    local override = Override:new(target_func_str, func)
    table.insert(self.overrides, override)
end
