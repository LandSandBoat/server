-----------------------------------
-- Area: Port Bastok
--  NPC: HomePoint#1
-- !pos 58.850 7.499 -27.790 236
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 14

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
