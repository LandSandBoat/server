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
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SLOW)

    mob:addListener('WEATHER_CHANGE', 'DOSETSU_TREE_WEATHER_CHANGE', function(mobArg, weather, element)
        if not mobArg:isSpawned() then
            return
        end

        if mobArg:isEngaged() then
            return
        end

        if xi.data.element.getWeatherElement(element) ~= xi.element.THUNDER then
            DespawnMob(mobArg:getID())
        end
    end)
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
    if xi.data.element.getWeatherElement(mob:getWeather()) ~= xi.element.THUNDER then
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    local respawn = math.randomInt(3600, 7200) -- 1-2 hours during thunder weather
    mob:setLocalVar('respawn', GetSystemTime() + respawn)
end

return entity
