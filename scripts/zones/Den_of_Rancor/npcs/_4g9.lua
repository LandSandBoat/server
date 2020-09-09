-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern
-- !pos 13.097 24.628 -303.353 160
-----------------------------------
require("scripts/zones/Den_of_Rancor/globals")
-----------------------------------

function onTrade(player, npc, trade)
    DEN_OF_RANCOR.onTradeLanternHaku(player, npc, trade)
end

function onTrigger(player, npc)
    DEN_OF_RANCOR.onTriggerLantern(player, npc)
end
