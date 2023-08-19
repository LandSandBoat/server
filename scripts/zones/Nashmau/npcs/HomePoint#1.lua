-----------------------------------
-- Area: Nashmau
--  NPC: HomePoint#1
-- !pos -19.860 0.001 -25.441 53
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 66

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
