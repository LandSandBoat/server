-----------------------------------
-- Area: Bibiki Bay
--  NPC: Fheli Lapatzuo
-- Type: Manaclipper Timekeeper
-- !pos 488.793 -4.003 709.473 4
-----------------------------------
require("scripts/globals/manaclipper")
-----------------------------------

local timekeeperLocation = tpz.manaclipper.location.SUNSET_DOCKS
local timekeeperEventId = 18

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
