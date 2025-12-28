-----------------------------------
-- Area: Ship Bound for Mhaura
--  NPC: Chhaya
-- !pos -1.139 -2.101 -9.000 221
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,  2595 },
        { xi.item.ANTIDOTE,             316 },
        { xi.item.FLASK_OF_ECHO_DROPS,  800 },
        { xi.item.POTION,               910 },
        { xi.item.ETHER,               4832 },
    }

    player:showText(npc, zones[xi.zone.SHIP_BOUND_FOR_MHAURA].text.CHHAYA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
