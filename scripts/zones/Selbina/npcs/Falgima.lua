-----------------------------------
-- Area: Selbina
--  NPC: Falgima
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SCROLL_OF_INVISIBLE,  5754 },
        { xi.item.SCROLL_OF_SNEAK,      2500 },
        { xi.item.SCROLL_OF_DEODORIZE,  1295 },
        { xi.item.SCROLL_OF_FLURRY,    33000 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.FALGIMA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
