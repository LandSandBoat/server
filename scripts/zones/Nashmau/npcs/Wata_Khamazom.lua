-----------------------------------
-- Area: Nashmau
--  NPC: Wata Khamazom
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SHORTBOW,             44 },
        { xi.item.SELF_BOW,            536 },
        { xi.item.WRAPPED_BOW,        7920 },
        { xi.item.LONGBOW,             492 },
        { xi.item.GREAT_BOW,         21812 },
        { xi.item.WOODEN_ARROW,          4 },
        { xi.item.IRON_ARROW,            8 },
        { xi.item.SILVER_ARROW,         18 },
        { xi.item.FIRE_ARROW,          140 },
        { xi.item.CROSSBOW_BOLT,         6 },
        { xi.item.THROWING_TOMAHAWK,   248 },
    }

    player:showText(npc, zones[xi.zone.NASHMAU].text.WATAKHAMAZOM_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
