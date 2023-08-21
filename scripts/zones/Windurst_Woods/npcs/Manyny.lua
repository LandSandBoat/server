-----------------------------------
-- Area: Windurst Woods
--  NPC: Manyny
-- Standard Merchant NPC
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        5032,  3112,       --Sinewy Etude
        5033,  2784,       --Dextrous Etude
        5034,  2184,       --Vivacious Etude
        5035,  1892,       --Quick Etude
        5036,  1550,       --Learned Etude
        5037,  1252,       --Spirited Etude
        5038,   990        --Enchanting Etude
    }
    player:showText(npc, ID.text.MANYNY_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
