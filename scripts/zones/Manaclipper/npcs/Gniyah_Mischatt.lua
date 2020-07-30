-----------------------------------
-- Area: Manaclipper
--  NPC: Gniyah Mischatt
-- Type: Manaclipper Timekeeper
-- !pos 0.033 -4 2.725 3
-----------------------------------
require("scripts/globals/manaclipper")
-----------------------------------

local timekeeperLocation = tpz.manaclipper.location.MANACLIPPER
local timekeeperEventId = 2

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
