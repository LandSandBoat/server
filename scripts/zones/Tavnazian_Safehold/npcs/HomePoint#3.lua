-----------------------------------
-- Area: Tavnazian_Safehold
--  NPC: HomePoint#3
-- !pos 73.59 -36.149 38.87 26
-----------------------------------
local entity = {}

local hpEvent = 8702
local hpIndex = 121

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
