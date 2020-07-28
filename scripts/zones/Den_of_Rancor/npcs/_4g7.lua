-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern (Red)
-- !pos -142.956 4.637 -173.018 160
-----------------------------------
require("scripts/zones/Den_of_Rancor/globals")
-----------------------------------

function onTrade(player, npc, trade)
    DEN_OF_RANCOR.onTradeLanternBoss(player, npc, trade)
end

function onTrigger(player, npc)
    DEN_OF_RANCOR.onTriggerLantern(player, npc)
end
