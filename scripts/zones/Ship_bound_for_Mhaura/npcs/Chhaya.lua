-----------------------------------
-- Area: Ship Bound for Mhaura
--  NPC: Chhaya
-- !pos -1.139 -2.101 -9.000 221
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4112,  910,    -- Potion
        4128, 4832,    -- Ether
        4148,  316,    -- Antidote
        4150, 2595,    -- Eye Drops
        4151,  800,    -- Echo Drops
    }

    player:showText(npc, ID.text.CHHAYA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
