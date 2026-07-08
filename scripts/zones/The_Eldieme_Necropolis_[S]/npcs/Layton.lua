-----------------------------------
-- Area: The Eldieme Necropolis (S)
--  NPC: Layton
-- Note: Available during Campaign battles
-- !pos 382.679 -39.999 3.541 175
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FIRESTORM_SCHEMA,     8060 },
        { xi.item.RAINSTORM_SCHEMA,     6318 },
        { xi.item.THUNDERSTORM_SCHEMA,  9100 },
        { xi.item.HAILSTORM_SCHEMA,     8580 },
        { xi.item.SANDSTORM_SCHEMA,     5200 },
        { xi.item.WINDSTORM_SCHEMA,     6786 },
        { xi.item.AURORASTORM_SCHEMA,  11440 },
        { xi.item.VOIDSTORM_SCHEMA,    10725 },
        { xi.item.PYROHELIX_SCHEMA,     7714 },
        { xi.item.HYDROHELIX_SCHEMA,    6786 },
        { xi.item.IONOHELIX_SCHEMA,     8625 },
        { xi.item.CRYOHELIX_SCHEMA,     7896 },
        { xi.item.GEOHELIX_SCHEMA,      6591 },
        { xi.item.ANEMOHELIX_SCHEMA,    6981 },
        { xi.item.LUMINOHELIX_SCHEMA,   8940 },
        { xi.item.NOCTOHELIX_SCHEMA,    8790 },
    }

    player:showText(npc, zones[xi.zone.THE_ELDIEME_NECROPOLIS_S].text.LAYTON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
