-----------------------------------
-- Area: Bostaunieux Obliette
--  NPC: Novalmauge
-- Starts and Finishes Quest: The Rumor, Souls in Shadow
-- Involved in Quest: The Holy Crest, Trouble at the Sluice
-- !pos 70 -24 21 167
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 41.169430, y = -24.000000, z = 19.860674 },
    { x = 42.256676, y = -24.000000, z = 19.885197 },
    { x = 41.168694, y = -24.000000, z = 19.904638 },
    { x = 21.859211, y = -24.010996, z = 19.792259 },
    { x = 51.917370, y = -23.924366, z = 19.970068 },
    { x = 74.570229, y = -24.024828, z = 20.103880 },
    { x = 44.533886, y = -23.947662, z = 19.926519 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
