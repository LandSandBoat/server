-----------------------------------
-- Area: Castle Zvahl Baileys
--   NM: Marquis Sabnock
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.MARQUIS_SABNOCK - 2] = ID.mob.MARQUIS_SABNOCK,
}

entity.spawnPoints =
{
    { x = 70.800, y = -8.000, z = -119.500 },
    { x = 63.285, y = -8.000, z = -102.540 },
    { x = 80.141, y = -8.000, z =  -99.397 },
    { x = 96.419, y = -8.000, z = -118.788 },
    { x = 91.070, y = -8.000, z = -138.734 },
    { x = 74.301, y = -8.000, z = -131.159 },
    { x = 84.099, y = -8.000, z = -121.188 },
    { x = 77.088, y = -8.000, z = -113.123 },
    { x = 68.494, y = -8.000, z = -117.972 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { power = math.random(10, 60) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 352)
end

return entity
