-----------------------------------
-- Area: Bastok Markets
--  NPC: Brunhilde
-- Standard Merchant NPC
-- !pos -305.775 -10.319 -152.173 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        12448,   154, 3,    -- Bronze Cap
        12432,  1334, 3,    -- Faceguard
        12433, 11776, 2,    -- Brass Mask
        12416, 29311, 2,    -- Sallet
        12576,   235, 3,    -- Bronze Harness
        12560,  2051, 3,    -- Scale Mail
        12561, 17928, 2,    -- Brass Scale Mail
        12704,   128, 3,    -- Bronze Mittens
        12688,  1094, 3,    -- Scale Finger Gauntlets
        12689,  9479, 2,    -- Brass Finger Gauntlets
        12417, 52289, 1,    -- Mythril Sallet
        12544, 45208, 1,    -- Breastplate
        12672, 23846, 1,    -- Gauntlets
    }

    player:showText(npc, ID.text.BRUNHILDE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
