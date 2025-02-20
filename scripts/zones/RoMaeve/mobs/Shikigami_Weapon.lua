-----------------------------------
-- Area: RoMaeve
--   NM: Shikigami Weapon
-----------------------------------
---@type TMobEntity
local entity = {}

local pathNodes =
{
    { x = -47, y = -4, z = -37 },
    { x = -49 },
    { x = -54 },
    { x = -59, z = -43 },
    { x = -67, y = -3.7, z = -50.6 },
    { x = -76, y = -1.4, z = -60 },
    { x = -87, y = -1, z = -69 },
    { x = -104, y = -3, z = -58 },
    { x = -118, y = -3, z = -46 },
    { x = -112, y = -3.5, z = -28 },
    { x = -98, y = -6, z = -16 },
    { x = -84, z = -9 },
    { x = -64, z = 1.1 },
    { x = -40, z = 9.6 },
    { x = -20, z = 12 },
    { x = -10, y = -6.2, z = 11 },
    { x = 31, y = -6, z = 11 },
    { x = 52, z = 5 },
    { x = 75, z = -4 },
    { x = 94, z = -14 },
    { x = 110, y = -4.2, z = -25 },
    { x = 118, y = -3, z = -34 },
    { x = 109, y = -3.25, z = -55 },
    { x = 87, y = -1, z = -70 },
    { x = 68, y = -3.3, z = -53 },
    { x = 57, y = -4, z = -41 },
    { x = 28, z = -37 },
    { x = 6, z = -35 },
    { x = -15, z = -36 },
    { x = -23 },
    { x = -35 },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMod(xi.mod.REGEN, 5) -- "Has a minor Auto Regen effect"
end

entity.onMobSpawn = function(mob)
    mob:setStatus(xi.status.INVISIBLE)
    mob:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

entity.onMobEngage = function(mob, target)
    mob:setStatus(xi.status.UPDATE)
end

entity.onMobDisengage = function(mob)
    mob:setStatus(xi.status.INVISIBLE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 119, 2, xi.regime.type.FIELDS)
end

return entity
