-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Bayawak
--  Only spawned during fire weather
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  199.614, y =  4.000, z =  240.307 },
    { x =  240.919, y =  4.000, z =  202.680 },
    { x =  291.329, y =  4.000, z =  283.012 },
    { x =  302.803, y =  4.251, z =  211.679 },
    { x =  347.081, y =  3.983, z =  187.811 },
    { x =  361.050, y =  4.000, z =  158.976 }
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 25)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobRoam = function(mob)
    local weather = mob:getWeather()
    if
        weather ~= xi.weather.HOT_SPELL and
        weather ~= xi.weather.HEAT_WAVE
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 363)
end

entity.onMobDespawn = function(mob)
    local respawn = math.random(5400, 7200)
    mob:setRespawnTime(respawn)
    mob:setLocalVar('respawn', GetSystemTime() + respawn)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no fire weather and immediate despawn
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
