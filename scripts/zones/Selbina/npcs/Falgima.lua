-----------------------------------
-- Area: Selbina
--  NPC: Falgima
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4744,  5351,    -- Scroll of Invisible
        4745,  2325,    -- Scroll of Sneak
        4746,  1204,    -- Scroll of Deodorize
        5104, 30360,    -- Scroll of Flurry
    }

    player:showText(npc, ID.text.FALGIMA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
