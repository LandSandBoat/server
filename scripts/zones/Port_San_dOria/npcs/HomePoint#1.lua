-----------------------------------
-- Area: Port San dOria
--  NPC: HomePoint#1
-- !pos -67.963 -4.000 -105.023 232
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 6

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
