-----------------------------------
-- Area: Qufim Island
--   NM: Dosetsu Tree
--  Only spawns during thunder weather
--  Level: 38-40 Treant NM
-----------------------------------
---@type TMobEntity
local entity = {}

-- Spawn points in F-8/G-9 area
entity.spawnPoints =
{
    { x = -240.000, y = -20.795, z =  37.000 },  -- Original database point (F-8 area)
    { x = -161.386, y = -20.190, z =  69.814 },  -- From packet capture (G-9 area)
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngage = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobRoam = function(mob)
    -- Re-root the mob once it returns to spawn point
    if utils.distanceWithin(mob:getPos(), mob:getSpawnPos(), 2, false) then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    end
end

entity.onMobDisengage = function(mob)
    local weather = mob:getWeather()
    if
        weather ~= xi.weather.THUNDER and
        weather ~= xi.weather.THUNDERSTORMS
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    local respawn = math.random(3600, 7200) -- 1-2 hours during thunder weather
    mob:setLocalVar('respawn', GetSystemTime() + respawn)
end

return entity
