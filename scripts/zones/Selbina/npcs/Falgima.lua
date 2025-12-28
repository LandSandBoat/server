-----------------------------------
-- Area: Selbina
--  NPC: Falgima
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_INVISIBLE,  5984 },
        { xi.item.SCROLL_OF_SNEAK,      2600 },
        { xi.item.SCROLL_OF_DEODORIZE,  1346 },
        { xi.item.SCROLL_OF_FLURRY,    34320 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.FALGIMA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
