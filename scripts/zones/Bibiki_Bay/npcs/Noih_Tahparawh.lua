-----------------------------------
-- Area: Bibiki Bay
--  NPC: Noih Tahparawh
-- Type: Manaclipper Timekeeper
-- !pos -392 -3 -385 4
-----------------------------------
require("scripts/globals/manaclipper")
-----------------------------------
local entity = {}

local timekeeperLocation = tpz.manaclipper.location.PURGONORGO_ISLE
local timekeeperEventId = 19

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
