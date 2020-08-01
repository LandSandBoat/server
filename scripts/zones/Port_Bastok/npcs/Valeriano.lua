-----------------------------------
-- Area: Port Bastok
--  NPC: Valeriano
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4394,     10,    -- Ginger Cookie
        17345,    43,    -- Flute
        17347,   990,    -- Piccolo
        5017,    585,    -- Scroll of Scop's Operetta
        5018,  16920,    -- Scroll of Puppet's Operetta
        5013,   2916,    -- Scroll of Fowl Aubade
        5027,   2059,    -- Scroll of Advancing March
        5072,  90000,    -- Scroll of Goddess's Hymnus
        5054,  32844,    -- Scroll of Fire Carol II
        5056,  30912,    -- Scroll of Wind Carol II
        5057,  27140,    -- Scroll of Earth Carol II
        5059,  28520,    -- Scroll of Water Carol II
        4996, 123880,    -- Scroll of Mage's Ballad III
    }

    player:showText(npc, ID.text.VALERIANO_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
