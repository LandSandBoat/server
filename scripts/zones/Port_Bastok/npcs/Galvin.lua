-----------------------------------
-- Area: Port Bastok
--  NPC: Galvin
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.FLASK_OF_EYE_DROPS,  2698, 3,
        xi.item.ANTIDOTE,             328, 3,
        xi.item.FLASK_OF_ECHO_DROPS,  832, 2,
        xi.item.POTION,               946, 2,
        xi.item.ETHER,               5025, 1,
        xi.item.WOODEN_ARROW,           4, 2,
        xi.item.IRON_ARROW,             8, 3,
        xi.item.CROSSBOW_BOLT,          6, 3,
    }

    player:showText(npc, ID.text.GALVIN_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
