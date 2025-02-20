-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Aveline
-- !pos -139 -6 46 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.FAERIE_APPLE,                45, 2,
        xi.item.SARUTA_ORANGE,               33, 1,
        xi.item.BUNCH_OF_SAN_DORIAN_GRAPES,  79, 3,
        xi.item.SAN_DORIAN_CARROT,           33, 3,
        xi.item.LA_THEINE_CABBAGE,           24, 2,
        xi.item.FROST_TURNIP,                33, 1,
        xi.item.FLASK_OF_OLIVE_OIL,          16, 3,
        xi.item.SPRIG_OF_SAGE,              192, 3,
        xi.item.HANDFUL_OF_BAY_LEAVES,      135, 1,
        xi.item.BOTTLE_OF_APPLE_VINEGAR,     91, 1,
    }

    player:showText(npc, ID.text.RAIMBROYS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
