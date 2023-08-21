-----------------------------------
-- Area: Southern San dOria
--  NPC: HomePoint#3
-- !pos 140 -2 123 230
-----------------------------------
local entity = {}

local hpEvent = 8702
local hpIndex = 2

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
