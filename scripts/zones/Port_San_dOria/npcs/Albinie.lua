-----------------------------------
-- Area: Port San d'Oria
--  NPC: Albinie
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        699, 5688, 1,    -- Oak Log
        644, 1800, 1,    -- Mythril Ore
        835,  225, 1,    -- Flax Flower
        694, 2543, 2,    -- Chestnut Log
        640,   10, 2,    -- Copper Ore
        643,  810, 2,    -- Iron Ore
        833,   18, 2,    -- Moko Grass
        4570,  50, 2,    -- Bird Egg
        698,   86, 3,    -- Ash Log
        1,   1800, 3,    -- Chocobo Bedding
    }

    player:showText(npc, ID.text.ALBINIE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
