-----------------------------------
-- Area: Bastok Markets
--  NPC: Ciqala
-- Type: Merchant
-- !pos -283.147 -11.319 -143.680 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        16392, 4818, 1,    -- Metal Knuckles
        17044, 6033, 1,    -- Warhammer
        16390,  224, 3,    -- Bronze Knuckles
        16391,  828, 3,    -- Brass Knuckles
        16385,  129, 3,    -- Cesti
        16407, 1521, 3,    -- Brass Baghnakhs
        16405,  104, 3,    -- Cat Baghnakhs
        17042,  312, 3,    -- Bronze Hammer
        17043, 2083, 3,    -- Brass Hammer
        17049,   47, 3,    -- Maple Wand
        17024,   66, 3,    -- Ash Club
        17059,   90, 3,    -- Bronze Rod
        17081,  621, 3,    -- Brass Rod
        17088,   57, 3,    -- Ash Staff
        17095,  386, 3,    -- Ash Pole
    }

    player:showText(npc, ID.text.CIQALA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
