-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pelftrix
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HI_POTION,  4500 },
        { xi.item.HI_ETHER,  28000 },
        { xi.item.SICKLE,      300 },
        { xi.item.HATCHET,     500 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS_S].text.PELFTRIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
