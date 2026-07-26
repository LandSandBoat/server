-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Malfud
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CHUNK_OF_ROCK_SALT,      16, astralCandescence = false },
        { xi.item.PINCH_OF_BLACK_PEPPER,  255, astralCandescence = false },
        { xi.item.FLASK_OF_OLIVE_OIL,      16, astralCandescence = false },
        { xi.item.EGGPLANT,                44, astralCandescence = false },
        { xi.item.MITHRAN_TOMATO,          40, astralCandescence = false },
        { xi.item.HANDFUL_OF_PINE_NUTS,    12, astralCandescence = true  },
    }

    player:showText(npc, ID.text.MALFUD_SHOP_DIALOG)
    xi.besieged.shop(player, stock)
end

return entity
