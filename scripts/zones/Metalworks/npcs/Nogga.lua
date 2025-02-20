-----------------------------------
-- Area: Metalworks
--  NPC: Nogga
-----------------------------------
local ID = zones[xi.zone.METALWORKS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BOMB_ARM,                  780, 2,
        xi.item.GRENADE,                  1252, 3,
        xi.item.FLASQUE_OF_CATALYTIC_OIL,  104, 3,
        xi.item.PINCH_OF_SOOT,             655, 1,
    }

    player:showText(npc, ID.text.NOGGA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
