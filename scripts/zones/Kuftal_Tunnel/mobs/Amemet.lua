-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Amemet
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

local path =
{
    {x = 105.03, y = -0.01, z = 26.04},
    {x = 109.88, y = 0.00, z = 45.25},
    {x = 104.56, y = -1.9, z = 60.02},
    {x = 101.12, y = -8.56, z = 78.06},
    {x = 100.54, y = -9.48, z = 99.99},
    {x = 97.68, y = -8.79, z = 124.00},
    {x = 93.38, y = -9.94, z = 137.06},
    {x = 78.21, y = -8.57, z = 140.23},
    {x = 64.04, y = -3.7, z = 143.38},
    {x = 49.70, y = -1.5, z = 147.42},
    {x = 32.56, y = 0.02, z = 150.01},
    {x = 17.94, y = -0.03, z = 137.00},
    {x = 7.12, y = 0.02, z = 117.76},
    {x = 4.74, y = 0.27, z = 99.64},
    {x = 17.30, y = -4.22, z = 54.34},
    {x = 19.45, y = -8.75, z = 40.65},
    {x = 25.23, y = -8.96, z = 24.95},
    {x = 40.71, y = -8.75, z = 21.33},
    {x = 64.58, y = -0.87, z = 13.55},
    {x = 88.68, y = -0.44, z = 12.39},
}

entity.onMobSpawn = function(mob)
    mob:pathThrough(path, xi.path.flag.PATROL)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 418)
end

return entity
