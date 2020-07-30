-----------------------------------
-- Area: Kazham
--  NPC: Ghemi Senterilo
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4468,   72,    -- Pamamas
        4432,   54,    -- Kazham Pineapple
        4390,   36,    -- Mithran Tomato
        612,    54,    -- Kazham Peppers
        628,   236,    -- Cinnamon
        632,   109,    -- Kukuru Bean
        5187,  156,    -- Elshimo Coconut
        5604,  154,    -- Elshimo Pachira Fruit
        2869, 9100,    -- Kazham Waystone
        731,  2877,    -- Aquilaria Log
    }

    player:showText(npc, ID.text.GHEMISENTERILO_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
