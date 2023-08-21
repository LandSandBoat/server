-----------------------------------
-- Area: Southern San dOria
--  NPC: HomePoint#1
-- !pos -85.468 1.000 -66.454 230
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 0

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
