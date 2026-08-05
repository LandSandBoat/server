-----------------------------------
-- Area: Port Bastok
--  NPC: Galvin
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,  2595, 3 },
        { xi.item.ANTIDOTE,             316, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,  800, 2 },
        { xi.item.POTION,               910, 2 },
        { xi.item.ETHER,               4786, 1 },
        { xi.item.WOODEN_ARROW,           4, 2 },
        { xi.item.IRON_ARROW,             8, 3 },
        { xi.item.CROSSBOW_BOLT,          6, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.GALVIN_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
