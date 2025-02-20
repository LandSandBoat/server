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
        xi.item.ASH_CLUB,           74, 3,
        xi.item.MAPLE_WAND,         54, 3,
        xi.item.WILLOW_WAND,       384, 3,
        xi.item.YEW_WAND,         1628, 1,
        xi.item.ASH_STAFF,          66, 3,
        xi.item.HOLLY_STAFF,       660, 3,
        xi.item.ELM_STAFF,        3750, 1,
        xi.item.ASH_POLE,          436, 3,
        xi.item.HOLLY_POLE,       5279, 2,
        xi.item.ELM_POLE,        18969, 1,
        xi.item.CESTI,             149, 3,
        xi.item.BRASS_KNUCKLES,    936, 3,
        xi.item.BRASS_BAGHNAKHS,  1757, 3,
        xi.item.BRONZE_ZAGHNAL,    357, 3,
        xi.item.BRASS_ZAGHNAL,    2938, 3,
        xi.item.ZAGHNAL,         13041, 1,
    }

    player:showText(npc, ID.text.ARLENNE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
