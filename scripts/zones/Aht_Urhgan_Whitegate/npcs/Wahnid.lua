-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Wahnid
-- Type: Guild Merchant: Fishing Guild
-- !pos -31.720 -6.000 -94.919 50
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(60426, 1, 18, 6)) then
        player:showText(npc, ID.text.WAHNID_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
