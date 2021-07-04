-----------------------------------
-- Garrison
-----------------------------------
require("scripts/globals/common")
require("scripts/globals/garrison_data")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}
xi.garrison.lookup = xi.garrison.lookup or {}

-----------------------------------
-- Helpers
-----------------------------------
local spawnMobs = function(mobList)
    for _, mobId in ipairs(mobList) do
        SpawnMob(mobId)
    end
end

local despawnMobs = function(mobList)
    for _, mobId in ipairs(mobList) do
        DespawnMob(mobId)
    end
end

-----------------------------------
-- Main Functions
-----------------------------------
xi.garrison.tick = function(npc)
    print("Garrison Tick")

    -- Extract data from lookup
    local zoneId = npc:getZoneID()
    local garrisonData = xi.garrison.lookup[zoneId]

    -- Check all registered Players are dead or invalid -> lose
    local setupTimer = false

    -- Check all NPCs are dead -> lose

    -- Check all Mobs are dead -> win

    -- Check Mobs in current wave are dead -> next wave
    local nextWave = 1
    xi.garrison.spawnWave(npc, nextWave)

    -- Make NPCs attack Mobs

    -- Make Mobs attack NPCs

    -- Tick again?
    if setupTimer then
        npc:timer(2400, function(npcArg)
            xi.garrison.tick(npcArg, false)
        end)
    end
end

xi.garrison.spawnNPCs = function(npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]

    -- Build npcList
    local npcList = {}
    for _, npcId in ipairs(garrisonZoneData.npcs) do
        table.insert(npcList, npcId)
    end

    spawnMobs(npcList)

    -- Apply confrontation effect

    -- DEBUG
    npc:timer(10000, function(npcArg)
        despawnMobs(npcList)
    end)
end

xi.garrison.spawnWave = function(npc, wave)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]

    -- Build mobList
    local mobList = {}
    for i = 1, wave do
        utils.concat(mobList, garrisonZoneData.waves[i])
    end

    spawnMobs(mobList)

    -- Apply confrontation effect

    -- DEBUG
    npc:timer(5000, function(npcArg)
        despawnMobs(mobList)
    end)
end

xi.garrison.start = function(player, npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]

    -- Collect entrant information
    local playerIdList = {}
    local leaderId = 0

    -- Stash information in lookup
    xi.garrison.lookup[zoneId] = xi.garrison.lookup[zoneId] or {}

    -- TODO: Scale amount of mobs and npcs, and store information in lookup

    -- Apply level cap + confrontation effect

    -- Wait 5s

    -- Spawn NPCs
    xi.garrison.spawnNPCs(npc)

    -- Wait 10s

    -- Start ticking
    xi.garrison.tick(npc)
end

xi.garrison.onTrigger = function(player, npc)
    -- TODO: Check to see if there is already a garrison running in this zone
    xi.garrison.start(player, npc)
end
