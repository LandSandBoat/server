-----------------------------------
-- Area: Kazham
--  NPC: Khifo Ryuhkowa
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        16473,   5713,    -- Kukri
        16595, 153014,    -- Ram-Dao
        16833,    809,    -- Bronze Spear
        16835,  16228,    -- Spear
        16839,  75541,    -- Partisan
        17025,   1600,    -- Chestnut Club
        17026,   4945,    -- Bone Cudgel
        17052,   5255,    -- Chestnut Wand
        17092,  29752,    -- Mahogany Staff
        17099,  99176,    -- Mahogany Pole
        17163,  39744,    -- Battle Bow
        17308,     55,    -- Hawkeye
        17280,   1610,    -- Boomerang
        17318,      3,    -- Woden Arrow
    }

    player:showText(npc, ID.text.KHIFORYUHKOWA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
