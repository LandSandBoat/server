-----------------------------------
-- Area: Mhaura
--  NPC: Tya Padolih
-- !pos -48 -4 30 249
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_REGEN,       4492 },
        { xi.item.SCROLL_OF_REGEN_II,    8143 },
        { xi.item.SCROLL_OF_SLEEPGA,    11648 },
        { xi.item.SCROLL_OF_BARAMNESIA, 31449 },
        { xi.item.SCROLL_OF_BARAMNESRA, 31449 },
        { xi.item.SCROLL_OF_INVISIBLE,   5984 },
        { xi.item.SCROLL_OF_SNEAK,       2600 },
        { xi.item.SCROLL_OF_DEODORIZE,   1346 },
        { xi.item.SCROLL_OF_DISTRACT,   20384 },
        { xi.item.SCROLL_OF_FRAZZLE,    28304 },
    }

    player:showText(npc, zones[xi.zone.MHAURA].text.TYAPADOLIH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
