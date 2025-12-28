-----------------------------------
-- Area: Rolanberry Fields
--   NM: Eldritch Edge
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  395.000, y = -24.000, z = -147.000 },
    { x =  388.000, y = -37.859, z = -162.602 },
    { x =  394.874, y = -23.888, z = -146.595 },
    { x =  377.940, y = -29.295, z = -150.296 },
    { x =  431.561, y = -20.440, z =  -59.401 },
    { x =  436.784, y = -22.906, z =  -70.260 },
    { x =  440.469, y = -28.826, z =  -48.646 },
    { x =  403.583, y = -24.000, z = -159.456 }
}

entity.phList =
{
    [ID.mob.ELDRITCH_EDGE + 2] = ID.mob.ELDRITCH_EDGE, -- 440 -28 -44
    [ID.mob.ELDRITCH_EDGE - 2] = ID.mob.ELDRITCH_EDGE, -- 396.992 -24.01 -152.613
    [ID.mob.ELDRITCH_EDGE - 1] = ID.mob.ELDRITCH_EDGE, -- 395 -24 -147
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 25)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 218)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
