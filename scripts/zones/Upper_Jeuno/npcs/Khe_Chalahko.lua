-----------------------------------
-- Area: Upper Jeuno
--  NPC: Khe Chalahko
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SALLET,         31860 },
        { xi.item.BREASTPLATE,    49140 },
        { xi.item.CUISSES,        37800 },
        { xi.item.PLATE_LEGGINGS, 23760 },
        { xi.item.BREECHES,       57750 },
        { xi.item.SOLLERETS,      35475 },
    }

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.DURABLE_SHIELDS_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
