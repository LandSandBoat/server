-----------------------------------
-- Area: Bibiki Bay
--  NPC: Noih Tahparawh
-- Type: Manaclipper Timekeeper
-- !pos -392 -3 -385 4
-----------------------------------
local entity = {}

local timekeeperLocation = xi.manaclipper.location.PURGONORGO_ISLE
local timekeeperEventId = 19

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
