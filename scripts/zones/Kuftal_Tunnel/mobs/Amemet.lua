-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Amemet
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

local pathNodes =
{
     17.94, -0.03, 137.00,
      7.12,  0.02, 117.76,
      4.74,  0.27,  99.64,
     17.30, -4.22,  54.34,
     19.45, -8.75,  40.65,
     25.23, -8.96, 24.95,
     40.71, -8.75,  21.33,
     64.58, -0.87,  13.55,
     88.68, -0.44,  12.39,
    105.03, -0.01,  26.04,
    109.88,  0.00,  45.25,
    104.56,  -1.9,  60.02,
    101.12, -8.56,  78.06,
    100.54, -9.48,  99.99,
     97.68, -8.79, 124.00,
     93.38, -9.94, 137.06,
     78.21, -8.57, 140.23,
     64.04, -3.60, 143.38,
     49.70, -0.08, 147.42,
     32.56,  0.02, 150.01,
}

entity.onPath = function(mob)
    xi.path.patrol(mob, pathNodes)
end

entity.onMobSpawn = function(mob)
    entity.onPath(mob)
end

entity.onMobRoam = function(mob)
    -- move to nearest path if not moving
    if not mob:isFollowingPath() then
        xi.path.pathToNearest(mob, pathNodes)
    end
end

entity.onMobDisengage = function(mob)
    xi.path.pathToNearest(mob, pathNodes)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 418)
end

return entity
