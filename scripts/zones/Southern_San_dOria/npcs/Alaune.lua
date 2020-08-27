-----------------------------------
-- Area: Southern San d`Oria
--   NPC: Alaune
-- Type: Tutorial NPC
-- !pos -90 1 -56 230
-----------------------------------
require("scripts/quests/tutorial")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.tutorial.onTrigger(player, npc, 916, 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.tutorial.onEventFinish(player, csid, option, 916, 0)
end
