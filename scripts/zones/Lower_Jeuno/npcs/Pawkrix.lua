-----------------------------------
-- Area: Lower Jeuno
--  NPC: Pawkrix
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BAG_OF_HORO_FLOUR,           40 },
        { xi.item.LOAF_OF_GOBLIN_BREAD,       300 },
        { xi.item.GOBLIN_PIE,                 650 },
        { xi.item.CHUNK_OF_GOBLIN_CHOCOLATE,   35 },
        { xi.item.GOBLIN_MUSHPOT,            1140 },
        { xi.item.BAG_OF_POISON_FLOUR,        515 },
        { xi.item.GOBLIN_DOLL,                500 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.PAWKRIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
