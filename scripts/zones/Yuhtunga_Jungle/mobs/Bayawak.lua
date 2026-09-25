-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Bayawak
--  Only spawned during fire weather
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.TERROR)

    mob:addListener('WEATHER_CHANGE', 'BAYAWAK_WEATHER_CHANGE', function(mobArg, weather, element)
        if not mobArg:isSpawned() then
            return
        end

        if mobArg:isEngaged() then
            return
        end

        if xi.data.element.getWeatherElement(element) ~= xi.element.FIRE then
            DespawnMob(mobArg:getID())
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 25)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDisengage = function(mob)
    if xi.data.element.getWeatherElement(mob:getWeather()) ~= xi.element.FIRE then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 363)
end

entity.onMobDespawn = function(mob)
    local respawn = math.randomInt(5400, 7200)
    mob:setRespawnTime(respawn)
    mob:setLocalVar('respawn', GetSystemTime() + respawn)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no fire weather and immediate despawn
end

return entity
