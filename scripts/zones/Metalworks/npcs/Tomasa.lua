-----------------------------------
-- Area: Metalworks
--  NPC: Tomasa
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

local path =
{
    -12.339, -10.000, -29.701,      -- TODO: arrives at location, turns left then waits at location for 8 seconds
    -13.796, -10.000, -19.127       -- TODO: arrives at location, turns left then waits at location for 8 seconds
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4396,  257, 1,    -- Sausage Roll
        4409,   73, 1,    -- Hard-Boiled Egg
        4417, 3036, 1,    -- Egg Soup
        4442,  368, 1,    -- Pineapple Juice
        4391,   22, 2,    -- Bretzel
        4578,  143, 2,    -- Sausage
        4424, 1012, 2,    -- Melon Juice
        4499,   92, 3,    -- Iron Bread
        4436,  294, 3,    -- Baked Popoto
        4455,  184, 3,    -- Pebble Soup
        4509,   10, 3,    -- Distilled Water
    }

    player:showText(npc, ID.text.TOMASA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
