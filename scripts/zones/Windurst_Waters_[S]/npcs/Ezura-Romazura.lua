-----------------------------------
-- Area: Windurst Waters [S]
--  NPC: Ezura-Romazura
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_STONE_V,    123750 },
        { xi.item.SCROLL_OF_WATER_V,    133110 },
        { xi.item.SCROLL_OF_AERO_V,     144875 },
        { xi.item.SCROLL_OF_FIRE_V,     162500 },
        { xi.item.SCROLL_OF_BLIZZARD_V, 186375 },
        { xi.item.SCROLL_OF_STONEJA,    168150 },
        { xi.item.SCROLL_OF_WATERJA,    176700 },
        { xi.item.SCROLL_OF_FIRAJA,     193800 },
        { xi.item.SCROLL_OF_AEROJA,     185240 },
        { xi.item.SCROLL_OF_BREAK,      126000 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS_S].text.EZURAROMAZURA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
