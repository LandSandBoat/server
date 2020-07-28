-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern (Blue)
-- !pos -136.840 4.742 -173.040 160
-----------------------------------
require("scripts/zones/Den_of_Rancor/globals")
-----------------------------------

function onTrade(player, npc, trade)
    DEN_OF_RANCOR.onTradeLanternBoss(player, npc, trade)
end

function onTrigger(player, npc)
    DEN_OF_RANCOR.onTriggerLantern(player, npc)
end
