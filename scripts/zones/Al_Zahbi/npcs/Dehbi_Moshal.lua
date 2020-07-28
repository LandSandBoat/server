-----------------------------------
-- Area: Al Zahbi
--  NPC: Dehbi Moshal
--  Guild Merchant NPC: Woodworking Guild
-- !pos -71.563 -5.999 -57.544 48
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:sendGuild(60428, 6, 21, 0) then
        player:showText(npc, ID.text.DEHBI_MOSHAL_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
