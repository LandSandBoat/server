-----------------------------------
-- Area: Pso'Xja
--  NPC: _096 (Stone Gate)
-- Notes: Spawns Gargoyle when triggered
-- !pos 290.000 -1.925 -98.399 9
-----------------------------------
local psoXjaGlobal = require('scripts/zones/PsoXja/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

local correctSideOfDoor = function(player)
    return player:getZPos() <= -99
end

entity.onTrade = function(player, npc, trade)
    psoXjaGlobal.attemptPickLock(player, npc, trade, correctSideOfDoor(player))
end

entity.onTrigger = function(player, npc)
    psoXjaGlobal.attemptOpenDoor(player, npc, correctSideOfDoor(player))
end

entity.onEventFinish = function(player, csid, option, npc)
    psoXjaGlobal.cs26EventFinish(player, csid, option)
end

return entity
