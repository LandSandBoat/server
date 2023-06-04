-----------------------------------
-- Module helpers
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.module = xi.module or {}

-- Helpers

-- Iterate through all the sections of a table-string, and instantiate them if they don't exist
-- Example: xi.module.ensureTable("xi.aName.anotherName") will ensure the table: xi.aName.anotherName
--        : is fully instantiated.
-- https://github.com/LandSandBoat/server/issues/3542#issuecomment-1407190523
xi.module.ensureTable = function(str)
    local parts = utils.splitStr(str, '.')
    local table = _G;
    for _, part in ipairs(parts) do
        table[part] = table[part] or {}
        table = table[part]
    end
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
