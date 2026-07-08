-----------------------------------
-- Area: Pso'Xja
--  NPC: _092 (Stone Gate)
-- Notes: Spawns Gargoyle when triggered
-- !pos 338.399 -1.925 -70.000 9
-----------------------------------
local psoXjaGlobal = require('scripts/zones/PsoXja/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

local correctSideOfDoor = function(player)
    return player:getXPos() >= 339
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
