-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ferdoulemiont
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        845,   1125, 1,    -- Black Chocobo Feather
        17307,    9, 2,    -- Dart
        17862,  680, 3,    -- Bug Broth
        17866,  680, 3,    -- Carrion Broth
        17860,   81, 3,    -- Carrot Broth
        17864,  124, 3,    -- Herbal Broth
        840,      7, 3,    -- Chocobo Feather
        4545,    61, 3,    -- Gysahl Greens
        17016,   10, 3,    -- Pet Food Alpha Biscuit
        17017,   81, 3,    -- Pet Food Beta Biscuit
        5073, 49680, 3,    -- Scroll of Chocobo Mazurka
        4997,    16, 3,    -- Scroll of Knight's Minne
        4998,   864, 3,    -- Scroll of Knight's Minne II
        4999,  5148, 3,    -- Scroll of Knight's Minne III
        2343,  1984, 3,    -- La Theine Millet
    }

    player:showText(npc, ID.text.FERDOULEMIONT_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
