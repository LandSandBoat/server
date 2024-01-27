-----------------------------------
-- Area: Windurst Waters
--  NPC: HomePoint#1
-- !pos -32.022 -5.000 131.741 238
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 17

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
