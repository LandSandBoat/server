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

local pathNodes =
{
    { x = -161.608, y = -7.480, z = -0.832 },
    { x = -161.454, z = -0.954, wait = 2000 },
    { x = -161.449, z = -0.919, wait = 5000 },
    { x = -161.454, z = -0.954 },
    { x = -161.716, z = -0.927 },
    { x = -162.779, z = -0.820 },
    { x = -163.727, z = -0.455 },
    { x = -168.236, z = 4.670, wait = 2000 },
    { x = -168.211, z = 4.695, wait = 5000 },
    { x = -163.727, z = -0.455 },
    { x = -162.779, z = -0.820 },
    { x = -161.716, z = -0.927 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
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
