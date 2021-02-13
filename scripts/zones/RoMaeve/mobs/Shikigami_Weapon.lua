-----------------------------------
-- Area: RoMaeve
--   NM: Shikigami Weapon
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local path =
{
    -47, -4, -37,
    -49, -4, -37,
    -54, -4, -37,
    -59, -4, -43,
    -67, -3.7, -50.6,
    -76, -1.4, -60,
    -87, -1, -69,
    -104, -3, -58,
    -118, -3, -46,
    -112, -3.5, -28,
    -98, -6, -16,
    -84, -6, -9,
    -64, -6, 1.1,
    -40, -6, 9.6,
    -20, -6, 12,
    -10, -6.2, 11,
    31, -6, 11,
    52, -6, 5,
    75, -6, -4,
    94, -6, -14,
    110, -4.2, -25,
    118, -3, -34,
    109, -3.25, -55,
    87, -1, -70,
    68, -3.3, -53,
    57, -4, -41,
    28, -4, -37,
    6, -4, -35,
    -15, -4, -36,
    -23, -4, -36,
    -35, -4, -36,
}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.REGEN, 5) -- "Has a minor Auto Regen effect"
end

entity.onMobSpawn = function(mob)
    mob:setStatus(tpz.status.INVISIBLE)
    entity.onMobRoam(mob)
end

entity.onPath = function(mob)
    tpz.path.patrol(mob, path, tpz.path.flag.RUN)
end

entity.onMobRoam = function(mob)
    -- move to start position if not moving
    if not mob:isFollowingPath() then
        mob:pathThrough(tpz.path.first(path), tpz.path.flag.RUN)
    end
end

entity.onMobEngaged = function(mob, target)
    mob:setStatus(tpz.status.UPDATE)
end

entity.onMobDisengage = function(mob)
    mob:setStatus(tpz.status.INVISIBLE)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 119, 2, tpz.regime.type.FIELDS)
end

return entity
