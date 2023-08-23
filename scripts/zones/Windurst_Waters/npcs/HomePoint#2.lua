-----------------------------------
-- Area: Windurst Waters
--  NPC: HomePoint#1
-- !pos 138 0.001 -14 238
-----------------------------------
local entity = {}

local hpEvent = 8701
local hpIndex = 18

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
