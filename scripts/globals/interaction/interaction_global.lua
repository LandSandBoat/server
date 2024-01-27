require('scripts/globals/utils')
require('scripts/globals/interaction/interaction_lookup')

-- Used by core to call into the loaded interaction handlers
InteractionGlobal = InteractionGlobal or {}
InteractionGlobal.lookup = InteractionGlobal.lookup or InteractionLookup:new()
InteractionGlobal.zones = InteractionGlobal.zones or {}

-----------------------------------
-- Called during server init:
-- [C++] do_init()
-- [C++] zoneutils::LoadZoneList()
-- [C++] luautils::InitInteractionGlobal()
-- [Lua] InteractionGlobal.initZones(zoneIds)
-----------------------------------
function InteractionGlobal.initZones(zoneIds)
    -- Add the given zones to the zones table
    for i = 1, #zoneIds do
        local zone = GetZone(zoneIds[i])
        if zone then
            InteractionGlobal.zones[zoneIds[i]] = zone:getName()
        end
    end

    InteractionGlobal.loadDefaultActions(false)
    InteractionGlobal.loadContainers(false)
end

-- Add container handlers found for the added zones
function InteractionGlobal.loadContainers(shouldReloadRequires)
    -- Convert from zero-index to one-index
    local zoneIds = {}
    for zoneId, _ in pairs(InteractionGlobal.zones) do
        zoneIds[#zoneIds + 1] = zoneId
    end

    local interactionContainersPath = 'scripts/globals/interaction_containers'
    if shouldReloadRequires then
        package.loaded[interactionContainersPath] = nil
    end

    local containerFiles = GetContainerFilenamesList()
    local containers = {}
    for i = 1, #containerFiles do
        containers[i] = utils.prequire(containerFiles[i])
        containers[i].filename = containerFiles[i]
    end

    InteractionGlobal.lookup:addContainers(containers, zoneIds)
end

-- Load default actions in added zones
function InteractionGlobal.loadDefaultActions(shouldReloadRequires)
    for zoneId, _ in pairs(InteractionGlobal.zones) do
        InteractionGlobal.loadDefaultActionsForZone(zoneId, shouldReloadRequires)
    end
end

local function fileExists(path)
    local f = io.open(path, 'r')
    return f ~= nil and io.close(f)
end

-- Load default actions for a specific zone
function InteractionGlobal.loadDefaultActionsForZone(zoneId, shouldReloadRequires)
    local zoneName = InteractionGlobal.zones[zoneId]
    if not zoneName then
        printf('Unable to load default actions for zone %d, since it hasn\'t been initialized.', zoneId)
        return
    end

    -- Path to zone-specific default actions
    local defaultActionPath = string.format('scripts/zones/%s/DefaultActions', zoneName)
    if shouldReloadRequires then
        package.loaded[defaultActionPath] = nil
    end

    -- Only add default handlers if DefaultActions file is found in zone directory
    if fileExists(defaultActionPath .. '.lua') then
        local ok, res = pcall(require, defaultActionPath)
        if ok then
            InteractionGlobal.lookup:addDefaultHandlers(zoneId, res)
        else
            printf('Error while loading default actions for %s: %s', zoneName, res)
            return
        end
    end
end

-- Reloads the framework which is useful during development
function InteractionGlobal.reload(shouldReloadData)
    if shouldReloadData then
        InteractionGlobal.lookup = InteractionLookup:new()
        InteractionGlobal.loadDefaultActions(true)
        InteractionGlobal.loadContainers(true)

    else
        InteractionGlobal.lookup = InteractionLookup:new(InteractionGlobal.lookup)
    end
end

function InteractionGlobal.afterZoneIn(player, fallbackFn)
    return InteractionGlobal.lookup:afterZoneIn(player, fallbackFn)
end

function InteractionGlobal.onTrigger(player, npc, fallbackFn)
    return InteractionGlobal.lookup:onTrigger(player, npc, fallbackFn)
end

function InteractionGlobal.onTrade(player, npc, trade, fallbackFn)
    return InteractionGlobal.lookup:onTrade(player, npc, trade, fallbackFn)
end

function InteractionGlobal.onMobDeath(mob, player, optParams, fallbackFn)
    return InteractionGlobal.lookup:onMobDeath(mob, player, optParams, fallbackFn)
end

function InteractionGlobal.onZoneIn(player, prevZone, fallbackFn)
    return InteractionGlobal.lookup:onZoneIn(player, prevZone, fallbackFn)
end

function InteractionGlobal.onZoneOut(player, fallbackFn)
    return InteractionGlobal.lookup:onZoneOut(player, fallbackFn)
end

function InteractionGlobal.onTriggerAreaEnter(player, triggerArea, instance, fallbackFn)
    return InteractionGlobal.lookup:onTriggerAreaEnter(player, triggerArea, instance, fallbackFn)
end

function InteractionGlobal.onTriggerAreaLeave(player, triggerArea, instance, fallbackFn)
    return InteractionGlobal.lookup:onTriggerAreaLeave(player, triggerArea, instance, fallbackFn)
end

function InteractionGlobal.onEventFinish(player, csid, option, npc, fallbackFn)
    return InteractionGlobal.lookup:onEventFinish(player, csid, option, npc, fallbackFn)
end

function InteractionGlobal.onEventUpdate(player, csid, option, npc, fallbackFn)
    return InteractionGlobal.lookup:onEventUpdate(player, csid, option, npc, fallbackFn)
end

return InteractionGlobal
