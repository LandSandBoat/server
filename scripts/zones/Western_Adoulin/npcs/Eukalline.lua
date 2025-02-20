-----------------------------------
-- Area: Western Adoulin
--  NPC: Eukalline
-- Type: Shop NPC
-- !pos 40 32 121 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Standard shop
    player:showText(npc, ID.text.EUKALLINE_SHOP_TEXT)
    local stock =
    {
        6085, 52080,  -- Scroll of Indi-Acumen
        6076, 53460,  -- Scroll of Indi-STR
        6099, 53460,  -- Scroll of Indi-Slow
        6096, 61875,  -- Scroll of Indi-Torpor
        6095, 83160,  -- Scroll of Indi-Slip
        6098, 94185,  -- Scroll of Indi-Languor
        6100, 103040, -- Scroll of Indi-Paralysis
        6097, 504000, -- Scroll of Indi-Vex
        6092, 537030, -- Scroll of Indi-Frailty
        6091, 576300, -- Scroll of Indi-Wilt
        6094, 617100, -- Scroll of Indi-Malaise
        6101, 617100, -- Scroll of Indi-Gravity
        6093, 703800, -- Scroll of Indi-Fade
        6131, 709716, -- Scroll of Indi-Haste
    }
    xi.shop.general(player, stock)
end

return entity
