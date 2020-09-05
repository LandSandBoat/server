-----------------------------------
-- Area: Bostaunieux Oubliette
--  NPC: Survival Guide
-----------------------------------
require("scripts/globals/survival_guide")
-----------------------------------

function onTrigger(player, targetNpc)
    tpz.survivalGuide.onTrigger(player)
end

function onEventUpdate(player, csid, option)
    tpz.survivalGuide.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, targetNpc)
    tpz.survivalGuide.onEventFinish(player, csid, option)
end
