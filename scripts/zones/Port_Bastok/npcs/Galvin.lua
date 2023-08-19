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
        xi.items.FLASK_OF_EYE_DROPS,  2698, 3,
        xi.items.ANTIDOTE,             328, 3,
        xi.items.FLASK_OF_ECHO_DROPS,  832, 2,
        xi.items.POTION,               946, 2,
        xi.items.ETHER,               5025, 1,
        xi.items.WOODEN_ARROW,           4, 2,
        xi.items.IRON_ARROW,             8, 3,
        xi.items.CROSSBOW_BOLT,          6, 3,
    }

    player:showText(npc, ID.text.GALVIN_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
