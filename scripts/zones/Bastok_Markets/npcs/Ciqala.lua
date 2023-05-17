-----------------------------------
-- Area: Bastok Markets
--  NPC: Ciqala
-- Type: Merchant
-- !pos -283.147 -11.319 -143.680 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        -- Only available while Bastok is in first.
        16392, 5447, 1,  -- Metal Knuckles
        16643, 12757, 1, -- Battleaxe
        16705, 4732, 1,  -- Greataxe
        17044, 6820, 1,  -- Warhammer
        -- Available when Bastok is in first or second.
        16391, 936, 2,   -- Brass Knuckles
        17043, 2407, 2,  -- Brass Hammer
        16641, 1622, 2,  -- Brass Axe
        16704, 698, 2,   -- Butterfly Axe
        -- Always available.
        16390, 253, 3,   -- Bronze Knuckles
        16640, 328, 3,   -- Bronze Axe
        17042, 353, 3,   -- Bronze Hammer
        17049, 54, 3,    -- Maple Wand
        17088, 66, 3,    -- Ash Staff

    }

    player:showText(npc, ID.text.CIQALA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
