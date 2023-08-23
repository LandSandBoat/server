-----------------------------------
-- Area: Ceizak Battlegrounds
--  NPC: HomePoint#1
-- !pos -107 3.2 295 261
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 46

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
