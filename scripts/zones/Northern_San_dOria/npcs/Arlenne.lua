-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arlenne
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17051,  1409, 1,    -- Yew Wand
        17090,  3245, 1,    -- Elm Staff
        17097, 16416, 1,    -- Elm Pole
        16770, 11286, 1,    -- Zaghnal
        17096,  4568, 2,    -- Holly Pole
        17024,    66, 3,    -- Ash Club
        17049,    46, 3,    -- Maple Wand
        17050,   333, 3,    -- Willow Wand
        17088,    57, 3,    -- Ash Staff
        17089,   571, 3,    -- Holly Staff
        17095,   386, 3,    -- Ash Pole
        16385,   132, 3,    -- Cesti
        16391,   828, 3,    -- Brass Knuckles
        16407,  1554, 3,    -- Brass Baghnakhs
        16768,   309, 3,    -- Bronze Zaghnal
        16769,  2542, 2,    -- Brass Zaghnal
    }

    player:showText(npc, ID.text.ARLENNE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
