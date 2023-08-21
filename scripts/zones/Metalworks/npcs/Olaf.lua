-----------------------------------
-- Area: Metalworks
--  NPC: Olaf
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.METALWORKS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.ARQUEBUS,          54121, 2,
        xi.item.BULLET,              104, 3,
        xi.item.PINCH_OF_BOMB_ASH,   535, 3,
    }

    player:showText(npc, ID.text.OLAF_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
