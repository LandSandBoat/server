-----------------------------------
-- Area: Windurst Woods
--  NPC: HomePoint#2
-- !pos 107 -5 -56 241
-----------------------------------
local entity = {}

local hpEvent = 8701
local hpIndex = 26

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
