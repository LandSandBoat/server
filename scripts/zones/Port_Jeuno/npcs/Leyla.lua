-----------------------------------
-- Area: Port Jeuno
--  NPC: Leyla
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        17308,  55,    -- Hawkeye
        17320,   7,    -- Iron Arrow
        17336,   5,    -- Crossbow Bolt
        4509,   10,    -- Distilled Water
        5038, 1000,    -- Enchanting Etude
        5037, 1265,    -- Spirited Etude
        5036, 1567,    -- Learned Etude
        5035, 1913,    -- Quick Etude
        5034, 2208,    -- Vivacious Etude
        5033, 2815,    -- Dextrous Etude
        5032, 3146,    -- Sinewy Etude
    }

    player:showText(npc, ID.text.DUTY_FREE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
