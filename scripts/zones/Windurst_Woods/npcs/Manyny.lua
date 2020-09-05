-----------------------------------
-- Area: Windurst Woods
--  NPC: Manyny
-- Standard Merchant NPC
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock = {
        5032,  3112,       --Sinewy Etude
        5033,  2784,       --Dextrous Etude
        5034,  2184,       --Vivacious Etude
        5035,  1892,       --Quick Etude
        5036,  1550,       --Learned Etude
        5037,  1252,       --Spirited Etude
        5038,   990        --Enchanting Etude
    }
    player:showText(npc, ID.text.MANYNY_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
