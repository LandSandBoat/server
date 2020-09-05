-----------------------------------
-- Area: Windurst Woods
--  NPC: Wije Tiren
-- Standard Merchant NPC
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.WIJETIREN_SHOP_DIALOG)

    local stock = {
        4148,   290,       --Antidote
        4509,    10,       --Distilled Water
        4151,   728,       --Echo Drops
        4128,  4445,       --Ether
        4150,  2387,       --Eye Drops
        4112,   837,       --Potion
        5014,    98,       --Scroll of Herb Pastoral
        2864,  9200        --Federation Waystone
    }
    tpz.shop.general(player, stock, WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
