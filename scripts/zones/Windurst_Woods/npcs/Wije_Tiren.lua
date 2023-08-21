-----------------------------------
-- Area: Windurst Woods
--  NPC: Wije Tiren
-- Standard Merchant NPC
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.WIJETIREN_SHOP_DIALOG)

    local stock =
    {
        4148,   290,       --Antidote
        4509,    10,       --Distilled Water
        4151,   728,       --Echo Drops
        4128,  4445,       --Ether
        4150,  2387,       --Eye Drops
        4112,   837,       --Potion
        5014,    98,       --Scroll of Herb Pastoral
        2864,  9200        --Federation Waystone
    }
    xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
