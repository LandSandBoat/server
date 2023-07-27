-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arlenne
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.ASH_CLUB,           74, 3,
        xi.items.MAPLE_WAND,         54, 3,
        xi.items.WILLOW_WAND,       384, 3,
        xi.items.YEW_WAND,         1628, 1,
        xi.items.ASH_STAFF,          66, 3,
        xi.items.HOLLY_STAFF,       660, 3,
        xi.items.ELM_STAFF,        3750, 1,
        xi.items.ASH_POLE,          436, 3,
        xi.items.HOLLY_POLE,       5279, 2,
        xi.items.ELM_POLE,        18969, 1,
        xi.items.CESTI,             149, 3,
        xi.items.BRASS_KNUCKLES,    936, 3,
        xi.items.BRASS_BAGHNAKHS,  1757, 3,
        xi.items.BRONZE_ZAGHNAL,    357, 3,
        xi.items.BRASS_ZAGHNAL,    2938, 3,
        xi.items.ZAGHNAL,         13041, 1,
    }

    player:showText(npc, ID.text.ARLENNE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
