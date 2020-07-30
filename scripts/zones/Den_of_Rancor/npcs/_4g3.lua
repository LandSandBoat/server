-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern (SW)
-- !pos -59 45 24 160
-----------------------------------
require("scripts/zones/Den_of_Rancor/globals")
-----------------------------------

function onTrade(player, npc, trade)
    DEN_OF_RANCOR.onTradeLanternChamber(player, npc, trade)
end

function onTrigger(player, npc)
    DEN_OF_RANCOR.onTriggerLantern(player, npc)
end
