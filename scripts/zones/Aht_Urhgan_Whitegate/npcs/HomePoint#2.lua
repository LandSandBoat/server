-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: HomePoint#2
-- !pos -130 0.001 -16 50
-----------------------------------
local entity = {}

local hpEvent = 8701
local hpIndex = 106

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
