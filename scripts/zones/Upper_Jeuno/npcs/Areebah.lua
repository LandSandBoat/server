-----------------------------------
-- Area: Upper Jeuno
--  NPC: Areebah
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        636,  119,    -- Chamomile
        951,  110,    -- Wijnruit
        948,   60,    -- Carnation
        941,   80,    -- Red Rose
        949,   96,    -- Rain Lily
        956,  120,    -- Lilac
        957,  120,    -- Amaryllis
        958,  120,    -- Marguerite
        2370, 520,    -- Flower Seeds
    }

    player:showText(npc, ID.text.MP_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
