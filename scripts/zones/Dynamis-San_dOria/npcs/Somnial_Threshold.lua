-----------------------------------
-- Area: Dynamis
--  NPC: Somnial Threshold
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onTrigger(player, npc)
    dynamis.somnialThresholdOnTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    dynamis.somnialThresholdOnEventFinish(player, csid, option)
end
