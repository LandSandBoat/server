-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Mikhe Aryohcha
-- Type: Standard NPC
-- !pos -56.645 -4.5 13.014 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.MIKHE_ARYOHCHA_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
