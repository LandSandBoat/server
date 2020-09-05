-----------------------------------
-- Area: Western Adoulin
--  NPC: Ishvad
-- Type: Shop NPC
-- !pos 44 32 125 256
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard shop
    player:showText(npc, ID.text.ISHVAD_SHOP_TEXT)
    local stock =
    {
        6074, 100,    -- Scroll of Indi-Poison
        6088, 372,    -- Scroll of Indi-Voidance
        6087, 1400,   -- Scroll of Indi-Precision
        6073, 2335,   -- Scroll of Indi-Regen
        6090, 2425,   -- Scroll of Indi-Attunement
        6089, 6692,   -- Scroll of Indi-Focus
        6084, 10926,  -- Scroll of Indi-Barrier
        6075, 21000,  -- Scroll of Indi-Refresh
        6082, 21000,  -- Scroll of Indi-CHR
        6081, 23940,  -- Scroll of Indi-MND
        6083, 25270,  -- Scroll of Indi-Fury
        6080, 30912,  -- Scroll of Indi-INT
        6079, 32640,  -- Scroll of Indi-AGI
        6086, 34000,  -- Scroll of Indi-Fend
        6078, 43740,  -- Scroll of Indi-VIT
        6077, 46440,  -- Scroll of Indi-DEX
    }
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
