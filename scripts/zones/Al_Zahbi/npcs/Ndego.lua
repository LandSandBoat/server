-----------------------------------
-- Area: Al Zahbi
--  NPC: Ndego
--  Guild Merchant NPC: Smithing Guild
-- !pos -37.192 0.000 -33.949 48
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:sendGuild(60427, 8, 23, 2) then
        player:showText(npc, ID.text.NDEGO_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
