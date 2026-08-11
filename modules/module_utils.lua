-----------------------------------
-- Module helpers
-----------------------------------
xi = xi or {}
xi.module = xi.module or {}

-- Module:new appends here; the loader drains it after each file.
xi.module.registry = xi.module.registry or {}

-- registerCommand stages here; the loader publishes once the file loads cleanly.
xi.module.commandRegistry = xi.module.commandRegistry or {}

-- Release order, matching the ENABLE_<tag> settings. addOverrideByEra sorts
-- cases by this value, so this order is the chronology.
xi.expansion =
{
    ROTZ      = 1,  -- Rise of the Zilart       (April 2003)
    COP       = 2,  -- Chains of Promathia      (September 2004)
    TOAU      = 3,  -- Treasures of Aht Urhgan  (April 2006)
    WOTG      = 4,  -- Wings of the Goddess     (November 2007)
    ACP       = 5,  -- A Crystalline Prophecy   (June 2009)
    AMK       = 6,  -- A Moogle Kupo d'Etat     (November 2009)
    ASA       = 7,  -- A Shantotto Ascension    (March 2010)
    ABYSSEA   = 8,  -- Abyssea add-ons          (June 2010)
    VOIDWATCH = 9,  -- Voidwatch                (November 2011)
    SOA       = 10, -- Seekers of Adoulin       (March 2013)
    ROV       = 11, -- Rhapsodies of Vana'diel  (May 2015)
    TVR       = 12, -- The Voracious Resurgence (August 2020)
}

-- Expansion value -> tag name, for the ENABLE_<tag> lookup.
local expansionNames = {}
for name, value in pairs(xi.expansion) do
    expansionNames[value] = name
end

--
-- applyOverride: Provides the "super" functionality for overriding functions
--
function applyOverride(base_table, name, func, fullname, filename)
    local old = base_table[name]

    local thisenv = getfenv(old)

    local env = { super = old }
    setmetatable(env, { __index = thisenv })

    setfenv(func, env)

    base_table[name] = func
end

--
-- Helpers
--

-- Iterate through all the sections of a table-string, and instantiate them if they don't exist
-- Example: xi.module.ensureTable('xi.aName.anotherName') will ensure the table: xi.aName.anotherName
--        : is fully instantiated.
-- https://github.com/LandSandBoat/server/issues/3542#issuecomment-1407190523
xi.module.ensureTable = function(str)
    local parts = utils.splitStr(str, '.')
    local table = _G
    for _, part in ipairs(parts) do
        table[part] = table[part] or {}
        table = table[part]
    end
end

xi.module.modifyInteractionEntry = function(filename, modifyFunc)
    package.loaded[filename] = nil -- Clear out the pre-required resource (it might not be there, but it doesn't matter)
    local res = utils.prequire(filename) -- Load the resource
    InteractionGlobal.lookup:removeContainer(res) -- Remove the resource from the container
    modifyFunc(res) -- Run function to modify resource
    InteractionGlobal.lookup:addContainer(res) -- Re-add resource to container
end

-- True when content restriction is on and this expansion's content is disabled.
xi.pre = function(expansion)
    local tag = expansionNames[expansion]
    if tag == nil then
        error(string.format('xi.pre: not an xi.expansion value: %s', tostring(expansion)))
    end

    if xi.settings == nil or xi.settings.main == nil then
        return false
    end

    local isRestricted = xi.settings.main.RESTRICT_CONTENT == 1 or xi.settings.main.RESTRICT_CONTENT == true
    if not isRestricted then
        return false
    end

    local contentSetting = xi.settings.main['ENABLE_' .. tag]
    return not (contentSetting == 1 or contentSetting == true)
end

-- Staged, not published: a file that errors later must not leave a
-- half-initialised command reachable by players.
xi.module.registerCommand = function(name, commandTable)
    if type(name) ~= 'string' or name == '' then
        error('registerCommand: invalid command name')
    end

    if
        type(commandTable) ~= 'table' or
        commandTable.cmdprops == nil or
        type(commandTable.onTrigger) ~= 'function'
    then
        error(string.format('registerCommand: %s requires cmdprops and onTrigger', name))
    end

    table.insert(xi.module.commandRegistry, { name = name, command = commandTable })
end

-- Override Object
Override = {}
Override.__index = Override

function Override:new(target_func_str, new_func, enabled, reason)
    local obj = {}
    setmetatable(obj, self)

    obj.name    = target_func_str
    obj.func    = new_func
    obj.enabled = enabled
    obj.reason  = reason -- why a disabled override was skipped, for the loader's debug log

    return obj
end

-- Module Object
--
-- A module is a bag of overrides. Overrides are always declared; the optional
-- condition only controls whether they are applied.
Module = {}
Module.__index = Module

function Module:new(name, condition)
    if type(name) ~= 'string' or string.len(name) < 5 then
        error(string.format('Invalid module name: %s', tostring(name)))
    end

    if condition ~= nil and type(condition) ~= 'boolean' then
        error(string.format('Module condition for %s must be a boolean, got %s', name, type(condition)))
    end

    local obj = {}
    setmetatable(obj, self)

    obj.name      = name
    obj.overrides = {}
    obj.enabled   = condition == nil or condition

    table.insert(xi.module.registry, obj)

    return obj
end

function Module:setEnabled(isEnabled)
    -- Settings arrive as numbers, and a non-boolean used to leave the module on.
    if type(isEnabled) ~= 'boolean' then
        error(string.format('setEnabled for %s must be a boolean, got %s', self.name, type(isEnabled)))
    end

    self.enabled = isEnabled
end

-- A mistyped constant arrives here as nil; reject it before the loader sees it.
local function assertOverrideTarget(target_func_str, caller)
    if type(target_func_str) ~= 'string' or target_func_str == '' then
        error(string.format('%s: target must be a non-empty string, got %s', caller, tostring(target_func_str)))
    end
end

function Module:addOverride(target_func_str, func)
    assertOverrideTarget(target_func_str, 'addOverride')

    if type(func) ~= 'function' then
        error(string.format('addOverride: %s requires a function', target_func_str))
    end

    table.insert(self.overrides, Override:new(target_func_str, func, true, nil))
end

-- One implementation per era, keyed by xi.expansion; a case applies when its
-- content is disabled. Declared newest first, so the oldest era wraps the rest.
function Module:addOverrideByEra(target_func_str, casesByEra)
    assertOverrideTarget(target_func_str, 'addOverrideByEra')

    local expansions = {}
    for expansion, func in pairs(casesByEra) do
        if expansionNames[expansion] == nil then
            error(string.format('addOverrideByEra: case for %s is not keyed by xi.expansion (got %s)', tostring(target_func_str), tostring(expansion)))
        end

        if type(func) ~= 'function' then
            error(string.format('addOverrideByEra: case %s for %s must be a function', expansionNames[expansion], tostring(target_func_str)))
        end

        table.insert(expansions, expansion)
    end

    if #expansions == 0 then
        error(string.format('addOverrideByEra: no cases declared for %s', tostring(target_func_str)))
    end

    table.sort(expansions, function(a, b)
        return a > b
    end)

    for _, expansion in ipairs(expansions) do
        local enabled = xi.pre(expansion)
        local reason  = nil

        if not enabled then
            reason = string.format('content %s is enabled', expansionNames[expansion])
        end

        table.insert(self.overrides, Override:new(target_func_str, casesByEra[expansion], enabled, reason))
    end
end
