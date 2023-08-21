-----------------------------------
-- Area: Nashmau
--  NPC: Poporoon
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12952,   336,    -- Leather Highboots
        12953,  3438,    -- Lizard Ledelsens
        12954, 11172,    -- Studded Boots
        12955, 20532,    -- Cuir Highboots
    }

    player:showText(npc, ID.text.POPOROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
