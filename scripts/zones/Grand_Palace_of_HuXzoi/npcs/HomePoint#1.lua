-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: HomePoint#3
-- !pos -12 0.5 -288 34
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 88

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
