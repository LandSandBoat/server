-----------------------------------
-- Area: Aht Urhfan Whitegate
--  NPC: Malfud
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CHUNK_OF_ROCK_SALT,      16, },
        { xi.item.PINCH_OF_BLACK_PEPPER,  255, },
        { xi.item.FLASK_OF_OLIVE_OIL,      16, },
        { xi.item.EGGPLANT,                44, },
        { xi.item.MITHRAN_TOMATO,          40, },
        { xi.item.HANDFUL_OF_PINE_NUTS,    12, },
    }

    player:showText(npc, ID.text.MALFUD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
