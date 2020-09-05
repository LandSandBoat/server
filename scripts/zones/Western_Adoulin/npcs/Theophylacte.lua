-----------------------------------
-- Area: Western Adoulin
--  NPC: Theophylacte
-- Type: Shop NPC
-- !pos 154 4 -33 256
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard shop
    player:showText(npc, ID.text.THEOPHYLACTE_SHOP_TEXT)
    local stock =
    {
        4112, 910,    -- Potion
        4116, 4500,   -- Hi-Potion
        4128, 4832,   -- Ether
        4132, 28000,  -- Hi-Ether
        4148, 316,    -- Antidote
        4151, 800,    -- Echo Drops
        4155, 3360,   -- Remedy
    }
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
