-----------------------------------
-- Area: Port Windurst
--  NPC: HomePoint#3
-- !pos 180 -12 226 240
-----------------------------------
local entity = {}

local hpEvent = 8702
local hpIndex = 24

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
