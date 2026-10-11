-----------------------------------
-- Area: Quicksand Caves
--   NM: Diamond Daig
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1200)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3000)
end

entity.onMobSpawnCheck = function(mob)
    -- Only pops during a sandstorm, non-zero keeps it out of its slot's roll
    local zone = mob:getZone()
    if zone and zone:getWeather() == xi.weather.SAND_STORM then
        return 0
    end

    return 1
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 428)
end

return entity
