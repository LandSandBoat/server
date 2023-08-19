-----------------------------------
-- Area: RuAun_Gardens
--  NPC: HomePoint#4
-- !pos 500 -42 158 130
-----------------------------------
local entity = {}

local hpEvent = 8703
local hpIndex = 62

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
