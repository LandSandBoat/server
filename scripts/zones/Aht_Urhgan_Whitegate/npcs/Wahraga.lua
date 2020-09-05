-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Wahraga
--  Guild Merchant: Alchemist Guild
-- !pos -76.836 -6.000 140.331 50
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(60425, 8, 23, 5)) then
        player:showText(npc, ID.text.WAHRAGA_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
