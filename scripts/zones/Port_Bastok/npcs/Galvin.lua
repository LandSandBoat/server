-----------------------------------
-- Area: Port Bastok
--  NPC: Galvin
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,  2724, 3 },
        { xi.item.ANTIDOTE,             331, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,  840, 2 },
        { xi.item.POTION,               955, 2 },
        { xi.item.ETHER,               5025, 1 },
        { xi.item.WOODEN_ARROW,           4, 2 },
        { xi.item.IRON_ARROW,             8, 3 },
        { xi.item.CROSSBOW_BOLT,          6, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.GALVIN_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
