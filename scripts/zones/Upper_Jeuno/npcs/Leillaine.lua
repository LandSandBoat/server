-----------------------------------
-- Area: Upper Jeuno
--  NPC: Leillaine
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4509,    10,    -- Distilled Water
        4150,  2387,    -- Eye Drops
        4148,   290,    -- Antidote
        4151,   736,    -- Echo Drops
        4112,   837,    -- Potion
        4128,  4445,    -- Ether
        4155, 22400,    -- Remedy
    }

    player:showText(npc, ID.text.LEILLAINE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
