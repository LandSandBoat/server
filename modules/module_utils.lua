-----------------------------------
-- Module helpers
-----------------------------------
require("scripts/globals/utils")
-----------------------------------

-- Override Object
Override = {}
Override.__index = Override

function Override:new(target_func_str, new_func)
    local obj = {}
    setmetatable(obj, self)

    local parts = utils.splitStr(target_func_str, ".")
    local parts_size = #parts

    local lookupTable = _G
    for i = 1, parts_size - 1 do
        local part = parts[i]
        lookupTable = lookupTable[part]
    end

    obj.base_table = lookupTable
    obj.name = parts[parts_size]
    obj.func = new_func

    return obj
end

function Override:apply()
    local old = self.base_table[self.name]
    local thisenv = getfenv(old)

    local env = { super = old }
    setmetatable(env, { __index = thisenv })

    setfenv(self.func, env)
    self.base_table[self.name] = self.func
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

function Module:apply()
    for _, override in ipairs(self.overrides) do
        override:apply()
    end
end
