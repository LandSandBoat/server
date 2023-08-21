-----------------------------------
-- Area: Metalworks
--  NPC: Nogga
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
        xi.items.BOMB_ARM,                  780, 2,
        xi.items.GRENADE,                  1252, 3,
        xi.items.FLASQUE_OF_CATALYTIC_OIL,  104, 3,
        xi.items.PINCH_OF_SOOT,             655, 1,
    }

    player:showText(npc, ID.text.NOGGA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
