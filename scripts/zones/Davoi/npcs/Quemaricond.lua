-----------------------------------
-- Area: Davoi
--  NPC: Quemaricond
-- Involved in Mission: Infiltrate Davoi
-- !pos 23 0.1 -23 149
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    20.6,    0,   -23,
      46,    0,   -19,
    53.5, -1.8,   -19,
      61, -1.1, -18.6,
    67.3, -1.5, -18.6,
      90, -0.5,   -19,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.QUEMARICOND_DIALOG)
    npc:clearPath(true)
    npc:wait(2000)
    npc:continuePath()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
