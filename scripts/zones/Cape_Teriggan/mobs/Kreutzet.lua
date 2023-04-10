-----------------------------------
-- Area: Cape Teriggan
--   NM: Kreutzet
-----------------------------------
require("scripts/globals/world")
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    if
        not mob:getWeather() == xi.weather.WIND and
        not mob:getWeather() == xi.weather.GALES
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 926 then
        local stormwindCounter = mob:getLocalVar("stormwindCounter")

        stormwindCounter = stormwindCounter + 1
        mob:setLocalVar("stormwindCounter", stormwindCounter)
        mob:setLocalVar("stormwindDamage", stormwindCounter) -- extra var for dmg calculation (in stormwind.lua)

        if stormwindCounter > 2 then
            mob:setLocalVar("stormwindCounter", 0)
        else
            mob:useMobAbility(926)
        end
    end
end

entity.onMobDisengage = function(mob, weather)
    if
        not mob:getWeather() == xi.weather.WIND and
        not mob:getWeather() == xi.weather.GALES
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Set Kruetzet's spawnpoint and respawn time (9-12 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(32400, 43200))
    mob:setLocalVar("cooldown", os.time() + mob:getRespawnTime() / 1000)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no wind weather and immediate despawn
end

return entity
