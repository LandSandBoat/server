-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Bayawak
--  Only spawned during fire weather
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 25)
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
    mob:setLocalVar('respawn', os.time() + respawn)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no fire weather and immediate despawn
    UpdateNMSpawnPoint(mob:getID())
end

return entity
