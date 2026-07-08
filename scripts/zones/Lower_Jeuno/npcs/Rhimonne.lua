-----------------------------------
-- Area: Lower Jeuno
--  NPC: Rhimonne
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS, 68 },
        { xi.item.CHOCOBO_FEATHER,         8 },
        { xi.item.DART,                   10 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.RHIMONNE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
