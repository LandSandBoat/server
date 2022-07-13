-----------------------------------
-- Area: Western Altepa Desert
--   NM: Dahu
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

-- TODO: Set nm_spawn_points

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.REGAIN, 200)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDisengage = function(mob)
    if not (mob:getWeather() == xi.weather.DUST_STORM or mob:getWeather() == xi.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end

entity.onMobRoam = function(mob)
    if not (mob:getWeather() == xi.weather.DUST_STORM or mob:getWeather() == xi.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 413)
        UpdateNMSpawnPoint(mob:getID())
        mob:setRespawnTime(3600)
        mob:setLocalVar("cooldown", os.time() + 3600)
        DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no earth weather and immediate despawn
end

return entity
