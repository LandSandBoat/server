-----------------------------------
-- Area: Mhaura
--  NPC: Pikini-Mikini
-- !pos -48 -4 30 249
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4150, 2335,    -- Eye Drops
        4148,  284,    -- Antidote
        4151,  720,    -- Echo Drops
        4112,  819,    -- Potion
        4509,   10,    -- Distilled Water
        917,  1821,    -- Parchment
        17395,   9,    -- Lugworm
        1021,  450,    -- Hatchet
        4376,  108,    -- Meat Jerky
        5299,  133,    -- Salsa
        2867, 9000,    -- Mhaura Waystone
    }

    player:showText(npc, ID.text.PIKINIMIKINI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
