-----------------------------------
-- Area: Bastok Markets
--  NPC: Charging Chocobo
-- Standard Merchant NPC
-- !pos -301.531 -10.319 -157.237 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        12832,   191, 3,    -- Bronze Subligar
        12816,  1646, 3,    -- Scale Cuisses
        12817, 14131, 2,    -- Brass Cuisses
        12800, 34776, 2,    -- Cuisses
        12960,   117, 3,    -- Bronze Leggings
        12944,   998, 3,    -- Scale Greaves
        12945,  8419, 2,    -- Brass Greaves
        12928, 21859, 2,    -- Plate Leggings
        13080, 16891, 2,    -- Gorget
        13192,   382, 3,    -- Leather Belt
        13196, 10166, 3,    -- Silver Belt
        12801, 58738, 1,    -- Mythril Cuisses
        12929, 36735, 1,    -- Mythril Leggings
        13198, 20037, 1,    -- Swordbelt
    }

    player:showText(npc, ID.text.CHARGINGCHOCOBO_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
