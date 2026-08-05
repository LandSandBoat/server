-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arlenne
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.ASH_CLUB,           72, 3, },
        { xi.item.MAPLE_WAND,         52, 3, },
        { xi.item.WILLOW_WAND,       370, 3, },
        { xi.item.YEW_WAND,         1566, 1, },
        { xi.item.ASH_STAFF,          63, 3, },
        { xi.item.HOLLY_STAFF,       635, 3, },
        { xi.item.ELM_STAFF,        3606, 1, },
        { xi.item.ASH_POLE,          420, 3, },
        { xi.item.HOLLY_POLE,       5076, 2, },
        { xi.item.ELM_POLE,        18240, 1, },
        { xi.item.CESTI,             144, 3, },
        { xi.item.BRASS_KNUCKLES,    900, 3, },
        { xi.item.BRASS_BAGHNAKHS,  1690, 3, },
        { xi.item.BRONZE_ZAGHNAL,    344, 3, },
        { xi.item.BRASS_ZAGHNAL,    2825, 3, },
        { xi.item.ZAGHNAL,         12540, 1, },
    }

    player:showText(npc, ID.text.ARLENNE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
