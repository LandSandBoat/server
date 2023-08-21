-----------------------------------
-- Area: Windurst Woods
--  NPC: HomePoint#1
-- !pos -98.588 0.001 -183.416 241
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 25

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
