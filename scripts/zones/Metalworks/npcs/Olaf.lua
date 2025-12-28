-----------------------------------
-- Area: Metalworks
--  NPC: Olaf
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.ARQUEBUS,          54642, 2 },
        { xi.item.BULLET,              105, 3 },
        { xi.item.PINCH_OF_BOMB_ASH,   540, 3 },
    }

    player:showText(npc, zones[xi.zone.METALWORKS].text.OLAF_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
