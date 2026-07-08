-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Gavrie
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,       2595, },
        { xi.item.ANTIDOTE,                  316, },
        { xi.item.FLASK_OF_ECHO_DROPS,       800, },
        { xi.item.POTION,                    910, },
        { xi.item.ETHER,                    4832, },
        { xi.item.REMEDY,                   3360, },
        { xi.item.FLASK_OF_DISTILLED_WATER,   12, },
        { xi.item.CAN_OF_AUTOMATON_OIL,       50, },
        { xi.item.CAN_OF_AUTOMATON_OIL_P1,   250, },
        { xi.item.CAN_OF_AUTOMATON_OIL_P2,   500, },
        { xi.item.CAN_OF_AUTOMATON_OIL_P3,  1000, },
    }

    player:showText(npc, ID.text.GAVRIE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
