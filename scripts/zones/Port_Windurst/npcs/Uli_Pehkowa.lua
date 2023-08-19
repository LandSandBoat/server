-----------------------------------
-- Area: Port Windurst
--  NPC: Uli Pehkowa
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        644, 1840, 1,    -- Mythril Ore
        835,  230, 1,    -- Flax Flower
        699, 5814, 1,    -- Oak Log
        698,   87, 2,    -- Ash Log
        694, 2599, 2,    -- Chestnut Log
        640,   11, 2,    -- Copper Ore
        643,  828, 2,    -- Iron Ore
        4570,  51, 2,    -- Bird Egg
        833,   18, 3,    -- Moko Grass
        114, 1840, 3,    -- My First Magic Kit
    }

    player:showText(npc, ID.text.ULIPEHKOWA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
