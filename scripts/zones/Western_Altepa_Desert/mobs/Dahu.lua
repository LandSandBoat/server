-----------------------------------
-- Area: Western Altepa Desert
--   NM: Dahu
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -442.983, y = -0.903, z =  288.538 },
    { x = -777.314, y = -8.219, z = -380.979 },
    { x = -786.485, y = -7.502, z = -443.898 },
    { x = -838.056, y = -7.471, z = -533.334 },
    { x = -882.349, y = -8.000, z = -517.288 },
    { x = -368.767, y =  0.117, z =  166.358 },
    { x = -392.339, y =  0.199, z =  273.405 },
    { x = -293.694, y =  0.335, z =  295.527 },
    { x = -218.086, y =  0.281, z =  218.271 },
    { x = -149.687, y =  0.164, z =  254.567 },
    { x = -108.388, y =  0.000, z =  210.599 },
    { x =  -49.921, y =  0.239, z =  231.733 },
    { x =  -10.889, y =  0.342, z =  201.307 },
    { x =   21.561, y =  0.703, z =  151.433 },
    { x =   64.333, y =  0.297, z =  174.984 },
    { x =   65.042, y =  0.000, z =  224.413 },
    { x =   31.647, y =  0.215, z =  237.132 },
    { x =  -21.875, y =  0.458, z =  246.920 },
    { x =  -75.693, y =  0.144, z =  273.371 }
}

local validWeather =
{
    xi.weather.DUST_STORM,
    xi.weather.SAND_STORM,
    xi.weather.HOT_SPELL,
    xi.weather.HEAT_WAVE,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 30)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobRoam = function(mob)
    local weather = mob:getWeather()

    if not utils.contains(weather, validWeather) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 413)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(3600)
end

return entity
