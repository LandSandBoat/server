-----------------------------------
-- Area: Metalworks
--  NPC: Nogga
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BOMB_ARM,                  750, 2 },
        { xi.item.GRENADE,                  1204, 3 },
        { xi.item.FLASQUE_OF_CATALYTIC_OIL,  100, 3 },
        { xi.item.PINCH_OF_SOOT,             630, 1 },
    }

    player:showText(npc, zones[xi.zone.METALWORKS].text.NOGGA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
