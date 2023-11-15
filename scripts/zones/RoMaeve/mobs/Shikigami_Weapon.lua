-----------------------------------
-- Area: RoMaeve
--   NM: Shikigami Weapon
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -47,  y = -4,    z = -37 },
    { x = -49,  y = -4,    z = -37 },
    { x = -54,  y = -4,    z = -37 },
    { x = -59,  y = -4,    z = -37 },
    { x = -67,  y = -3.7,  z = -50.6 },
    { x = -76,  y = -1.4,  z = -60 },
    { x = -87,  y = -1,    z = -69 },
    { x = -104, y = -3,    z = -58 },
    { x = -118, y = -3,    z = -46 },
    { x = -112, y = -3.5,  z = -28 },
    { x = -98,  y = -6,    z = -16 },
    { x = -84,  y = -6,    z = -9  },
    { x = -64,  y = -6,    z = 1.1 },
    { x = -40,  y = -6,    z = 9.6 },
    { x = -20,  y = -6,    z = 12  },
    { x = -10,  y = -6.2,  z = 11  },
    { x = 31,   y = -6,    z = 11  },
    { x = 52,   y = -6,    z = 5   },
    { x = 75,   y = -6,    z = -4  },
    { x = 94,   y = -6,    z = -14 },
    { x = 110,  y = -4.2,  z = -25 },
    { x = 118,  y = -3,    z = -34 },
    { x = 109,  y = -3.25, z = -55 },
    { x = 87,   y = -1,    z = -70 },
    { x = 68,   y = -3.3,  z = -53 },
    { x = 57,   y = -4,    z = -41 },
    { x = 28,   y = -4,    z = -37 },
    { x = 6,    y = -4,    z = -35 },
    { x = -15,  y = -4,    z = -36 },
    { x = -23,  y = -4,    z = -36 },
    { x = -35,  y = -4,    z = -36 },
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGEN, 5) -- "Has a minor Auto Regen effect"
end

entity.onMobSpawn = function(mob)
    mob:setStatus(xi.status.INVISIBLE)
end

entity.onMobEngaged = function(mob, target)
    mob:setStatus(xi.status.UPDATE)
end

entity.onMobDisengage = function(mob)
    mob:setStatus(xi.status.INVISIBLE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 119, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, 75600) -- 21 hours
end

entity.onMobRoam = function(mob)
    xi.path.randomPath(mob, pathNodes)
end

return entity
