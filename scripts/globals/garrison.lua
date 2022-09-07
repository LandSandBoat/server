-----------------------------------
-- Garrison
-----------------------------------
require('scripts/globals/mobs')
require('scripts/globals/common')
require('scripts/globals/npc_util')
require('scripts/settings/main')
require('scripts/globals/status')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/globals/pathfind')
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}
xi.garrison.lookup = xi.garrison.lookup or {}

-----------------------------------
-- Helpers
-----------------------------------

xi.garrison.onWin = function(player, npc)
end

xi.garrison.onLose = function(player, npc)
end

xi.garrison.onStatusRemove = function(player, npc)
end

xi.garrison.mobsAlive = function(player)
end

xi.garrison.npcAlive = function(player)
end

xi.garrison.despawnNPCs = function(npc)
end

xi.garrison.clearNPCs = function(zone)
end

xi.garrison.returnHome = function(mob)
end

xi.garrison.npcTableEmpty = function(zone)
end

-----------------------------------
-- Main Functions
-----------------------------------

xi.garrison.tick = function(player, npc, wave, party)
end

xi.garrison.spawnNPCs = function(npc, party)
end

xi.garrison.spawnWave = function(player, npc, wave, party)
end

xi.garrison.start = function(player, npc, party)
end

xi.garrison.onTrade = function(player, npc, trade, guardNation)
    return false
end

-- Get dialog fron guard after winning or losing
xi.garrison.onTrigger = function(player, npc)
    return false
end

-- Zone tick Create NPC Tables if empty
xi.garrison.buildNpcTable = function(zone)
end
