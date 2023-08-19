-----------------------------------
-- Area: AlTaieu
--  NPC: HomePoint#3
-- !pos 569 0 410 33
-----------------------------------
local entity = {}

local hpEvent = 8702
local hpIndex = 87

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
