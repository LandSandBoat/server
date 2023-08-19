-----------------------------------
-- Area: Windurst Waters
--  NPC: HomePoint#4
-- !pos -92 -2 54 238
-----------------------------------
local entity = {}

local hpEvent = 8703
local hpIndex = 118

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
