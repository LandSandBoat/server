-----------------------------------
-- Area: Bastok Mines
--   NPC: Sodragamm
-- Type: Item Deliverer
-- !pos -24.741 -1 -64.944 234
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
