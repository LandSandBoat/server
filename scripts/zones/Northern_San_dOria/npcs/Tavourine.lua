-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Tavourine
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
        xi.items.BRONZE_KNIFE,       170, 3,
        xi.items.KNIFE,             2522, 3,
        xi.items.BRONZE_ROD,         104, 3,
        xi.items.BRASS_ROD,          717, 3,
        xi.items.ROD,               2758, 1,
        xi.items.BRONZE_MACE,        195, 3,
        xi.items.MACE,              5041, 2,
        xi.items.BRONZE_AXE,         328, 3,
        xi.items.CLAYMORE,          2828, 3,
        xi.items.MYTHRIL_CLAYMORE, 43680, 1,
        xi.items.BRONZE_SPEAR,       915, 3,
        xi.items.BRASS_SPEAR,       5408, 3,
        xi.items.SPEAR,            18345, 3,
        xi.items.LANCE,            19156, 3,
    }

    player:showText(npc, ID.text.TAVOURINE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
