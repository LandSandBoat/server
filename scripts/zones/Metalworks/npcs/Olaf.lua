-----------------------------------
-- Area: Metalworks
--  NPC: Olaf
-----------------------------------
local ID = zones[xi.zone.METALWORKS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.ARQUEBUS,          54121, 2,
        xi.item.BULLET,              104, 3,
        xi.item.PINCH_OF_BOMB_ASH,   535, 3,
    }

    player:showText(npc, ID.text.OLAF_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
