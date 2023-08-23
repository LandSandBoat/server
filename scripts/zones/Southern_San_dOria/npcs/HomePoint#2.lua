-----------------------------------
-- Area: Southern San dOria
--  NPC: HomePoint#2
-- !pos 45 2 -35 230
-----------------------------------
local entity = {}

local hpEvent = 8701
local hpIndex = 1

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
