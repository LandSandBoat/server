-----------------------------------
-- Area: Al Zahbi
--  NPC: Bornahn
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos 46.011 0.000 -42.713 48
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(60429, 8, 23, 4)) then
        player:showText(npc, ID.text.BORNAHN_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
