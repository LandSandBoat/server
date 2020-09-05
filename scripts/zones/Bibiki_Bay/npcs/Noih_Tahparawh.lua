-----------------------------------
-- Area: Bibiki Bay
--  NPC: Noih Tahparawh
-- Type: Manaclipper Timekeeper
-- !pos -392 -3 -385 4
-----------------------------------
require("scripts/globals/manaclipper")
-----------------------------------

local timekeeperLocation = tpz.manaclipper.location.PURGONORGO_ISLE
local timekeeperEventId = 19

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
