-----------------------------------
-- Area: Cape Teriggan
--   NM: Kreutzet
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 207.000, y = 8.000, z =  1.000 },
    { x = 206.815, y = 7.997, z = 30.988 },
    { x = 239.461, y = 8.000, z = 36.764 },
    { x = 244.884, y = 7.931, z = 40.973 },
    { x = 244.047, y = 8.146, z = 26.193 },
    { x = 221.894, y = 8.711, z =  5.048 },
    { x = 222.966, y = 8.720, z = 41.007 },
    { x = 240.480, y = 8.654, z = 25.099 },
    { x = 219.439, y = 8.564, z = 33.017 },
    { x = 240.067, y = 8.000, z =  1.721 },
    { x = 236.722, y = 8.000, z = -0.087 },
    { x = 195.826, y = 8.928, z = 20.979 },
    { x = 195.346, y = 7.927, z = -3.773 },
    { x = 220.577, y = 8.427, z = 30.107 },
    { x = 218.173, y = 8.100, z = 26.092 },
    { x = 199.508, y = 7.895, z = -5.253 },
    { x = 196.715, y = 7.828, z = -5.807 },
    { x = 194.765, y = 8.846, z = 20.230 },
    { x = 220.090, y = 8.126, z =  9.681 },
    { x = 227.246, y = 8.471, z =  2.083 },
    { x = 246.034, y = 7.608, z = 45.278 },
    { x = 232.415, y = 8.100, z = 19.069 },
    { x = 201.074, y = 8.871, z = 22.568 },
    { x = 210.586, y = 8.328, z =  0.311 },
    { x = 199.051, y = 7.937, z =  6.562 },
    { x = 200.441, y = 8.781, z = 15.856 },
    { x = 229.327, y = 8.764, z = 28.575 },
    { x = 211.166, y = 7.988, z = 25.686 },
    { x = 210.313, y = 8.263, z = 34.996 },
    { x = 231.180, y = 8.240, z = 43.909 },
    { x = 193.963, y = 8.621, z = 23.393 },
    { x = 237.159, y = 8.000, z = 43.954 },
    { x = 217.593, y = 8.030, z = 23.653 },
    { x = 204.687, y = 8.550, z = 25.036 },
    { x = 193.197, y = 8.309, z = 25.924 },
    { x = 243.570, y = 8.340, z = 19.768 },
    { x = 210.190, y = 8.359, z = 18.490 },
    { x = 200.336, y = 8.888, z = 22.221 },
    { x = 199.780, y = 8.765, z = 16.027 },
    { x = 229.661, y = 7.827, z = 15.166 },
    { x = 244.466, y = 8.016, z = 28.147 },
    { x = 204.147, y = 7.817, z = 32.244 },
    { x = 202.704, y = 8.092, z = 28.186 },
    { x = 201.210, y = 7.759, z = -6.282 },
    { x = 193.966, y = 7.581, z =  1.438 },
    { x = 216.624, y = 8.830, z = 38.086 },
    { x = 196.589, y = 8.958, z = 19.674 },
    { x = 234.765, y = 8.136, z = 10.814 },
    { x = 200.606, y = 8.867, z = 22.649 },
    { x = 222.503, y = 8.874, z =  3.716 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(32400, 43200)) -- 9 to 12 hours
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no wind weather and immediate despawn
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobRoam = function(mob)
    local weather = mob:getWeather()
    if
        weather ~= xi.weather.WIND and
        weather ~= xi.weather.GALES
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobFight = function(mob, target)
    local stormwindCounter = mob:getLocalVar('stormwindCounter')
    if mob:canUseAbilities() then
        if stormwindCounter == 3 then
            mob:setLocalVar('stormwindCounter', 0)
        elseif
            stormwindCounter >= 1 and
            mob:checkDistance(target) <= 15
        then
            stormwindCounter = stormwindCounter + 1
            mob:setLocalVar('stormwindCounter', stormwindCounter)
            mob:setLocalVar('stormwindDamage', stormwindCounter) -- extra var for dmg calculation (in stormwind.lua)
            mob:useMobAbility(926)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local stormwindCounter = mob:getLocalVar('stormwindCounter')
    if
        skill:getID() == 926 and
        stormwindCounter == 0
    then
        mob:setLocalVar('stormwindCounter', 1)
        mob:setLocalVar('stormwindDamage', 1)
    end
end

entity.onMobDespawn = function(mob)
    -- Set Kruetzet's spawnpoint and respawn time (9-12 hours)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(32400, 43200))
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no wind weather and immediate despawn
end

return entity
