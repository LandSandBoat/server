-----------------------------------
-- Area: Port Bastok
--  NPC: Melloa
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -161.608, -7.480, -0.832,
    -161.454, -7.480, -0.954,
    -161.454, -7.480, -0.954,
    -161.454, -7.480, -0.954,
    -161.454, -7.480, -0.954,
    -161.449, -7.480, -0.919,
    -161.449, -7.480, -0.919,
    -161.449, -7.480, -0.919,
    -161.449, -7.480, -0.919,
    -161.449, -7.480, -0.919,
    -161.449, -7.480, -0.919,
    -161.449, -7.480, -0.919,
    -161.449, -7.480, -0.919,
    -161.454, -7.480, -0.954,
    -161.716, -7.480, -0.927,
    -162.779, -7.480, -0.820,
    -163.727, -7.480, -0.455,
    -168.236, -7.480, 4.670,
    -168.236, -7.480, 4.670,
    -168.236, -7.480, 4.670,
    -168.236, -7.480, 4.670,
    -168.211, -7.480, 4.695,
    -168.211, -7.480, 4.695,
    -168.211, -7.480, 4.695,
    -168.211, -7.480, 4.695,
    -168.211, -7.480, 4.695,
    -168.211, -7.480, 4.695,
    -168.211, -7.480, 4.695,
    -168.211, -7.480, 4.695,
    -168.211, -7.480, 4.695,
    -163.727, -7.480, -0.455,
    -162.779, -7.480, -0.820,
    -161.716, -7.480, -0.927,
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
        4591,  147, 1,    -- Pumpernickel
        4417, 3036, 1,    -- Egg Soup
        4442,  368, 1,    -- Pineapple Juice
        4391,   22, 2,    -- Bretzel
        4578,  143, 2,    -- Sausage
        4424, 1012, 2,    -- Melon Juice
        4437,  662, 2,    -- Roast Mutton
        4499,   92, 3,    -- Iron Bread
        4436,  294, 3,    -- Baked Popoto
        4455,  184, 3,    -- Pebble Soup
        4509,   10, 3,    -- Distilled Water
    }

    player:showText(npc, ID.text.MELLOA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
