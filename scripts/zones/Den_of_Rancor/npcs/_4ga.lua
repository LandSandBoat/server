-----------------------------------
-- Area: Den of Rancor
--  NPC: Lantern
-- !pos 12.993 24.746 -296.651 160
-----------------------------------
require("scripts/zones/Den_of_Rancor/globals")
-----------------------------------

function onTrade(player, npc, trade)
    DEN_OF_RANCOR.onTradeLanternHaku(player, npc, trade)
end

function onTrigger(player, npc)
    DEN_OF_RANCOR.onTriggerLantern(player, npc)
end
