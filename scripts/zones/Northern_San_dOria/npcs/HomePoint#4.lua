-----------------------------------
-- Area: Northern San dOria
--  NPC: HomePoint#4
-- !pos -132 12 195 231
-----------------------------------
local entity = {}

local hpEvent = 8703
local hpIndex = 98

entity.onTrigger = function(player, npc)
    xi.homepoint.onTrigger(player, hpEvent, hpIndex)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.homepoint.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.homepoint.onEventFinish(player, csid, option, hpEvent)
end

return entity
