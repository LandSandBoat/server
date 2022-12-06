-----------------------------------
-- Area: Cape Teriggan
--   NM: Kreutzet
-----------------------------------
require("scripts/globals/world")
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    if
        not (mob:getWeather() == xi.weather.WIND or
        mob:getWeather() == xi.weather.GALES)
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
        elseif mob:checkDistance(target) < 6 then
            mob:useMobAbility(926)
        end
    end
end

entity.onMobDisengage = function(mob, weather)
    if
        not (mob:getWeather() == xi.weather.WIND or
        mob:getWeather() == xi.weather.GALES)
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(32400, 43200)) -- 9 to 12 hours
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no wind weather and immediate despawn
end

return entity
