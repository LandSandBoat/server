-----------------------------------
-- Area: Lower Jeuno
--  NPC: Stinknix
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        943,    294, -- Poison Dust
        944,   1035, -- Venom Dust
        945,   2000, -- Paralysis Dust
        17320,    7, -- Iron Arrow
        17336,    5, -- Crossbow Bolt
        17313, 1107, -- Grenade
        2865, 10000, -- Dutchy Waystone
    }

    player:showText(npc, ID.text.JUNK_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
