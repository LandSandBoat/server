-----------------------------------
-- Area: Kazham
--  NPC: Toji Mumosulah
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        112,    456,    -- Yellow Jar
        13199,   95,    -- Blood Stone
        13076, 3510,    -- Fang Necklace
        13321, 1667,    -- Bone Earring
        17351, 4747,    -- Gemshorn
        16993,   69,    -- Peeled Crayfish
        16998,   36,    -- Insect Paste
        17876,  165,    -- Fish Broth
        17880,  695,    -- Seedbed Soil
        1021,   450,    -- Hatchet
        4987,   328,    -- Scroll of Army's Paeon II
        5079, 64528,    -- Scroll of Foe Lullaby II
        4988,  3312,    -- Scroll of Army's Paeon III
        4964,  8726,    -- Scroll of Monomi: Ichi
    }

    player:showText(npc, ID.text.TOJIMUMOSULAH_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
