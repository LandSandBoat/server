-----------------------------------
-- Area: Norg
--  NPC: Louartain
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    41.878349, -6.282223, 10.820915,
    42.088036, -6.282223, 11.867051,
    42.096603, -6.282223, 12.939011,
    42.104187, -6.282223, 17.270992,
    42.126625, -6.282223, 14.951096,
    42.097260, -6.282223, 10.187170,
    42.104218, -6.282223, 17.303179,
    42.128235, -6.282223, 14.767291,
    42.097534, -6.282223, 10.223410
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
    player:startEvent(84)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
