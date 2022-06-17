-----------------------------------
-- Area: Western Altepa Desert
--   NM: King Vinegarroon
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/world")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
<<<<<<< HEAD
    mob:setMobMod(xi.mobMod.DRAW_IN, 2) -- Aliance draw in
=======
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 10)

>>>>>>> de3620867a (King V bug fixes)
end

entity.onMobDrawIn = function(mob, target)
    -- todo make him use AoE tp move
    mob:addTP(3000)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY, {chance = 100})
end

entity.onMobDisengage = function(mob)
    local weather = mob:getWeather()

    if weather ~= xi.weather.DUST_STORM and weather ~= xi.weather.SAND_STORM then
        DespawnMob(mob:getID())
    end
end

entity.onMobRoam = function(mob)
    local weather = mob:getWeather()
    entity.mobRegen(mob)

    if weather ~= xi.weather.DUST_STORM and weather ~= xi.weather.SAND_STORM then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.VINEGAR_EVAPORATOR)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

<<<<<<< HEAD
entity.onMobFight = function(mob, target)
    local mobRegen = function()
        local hour = VanadielHour()
=======
entity.mobRegen = function(mob)
    local hour = VanadielHour()
>>>>>>> de3620867a (King V bug fixes)

    if hour >= 6 and hour <= 20 then
        mob:setMod(xi.mod.REGEN, 125)
    else
        mob:setMod(xi.mod.REGEN, 250)
    end
<<<<<<< HEAD
    end

    mobRegen()
=======
end

entity.onMobFight = function(mob, target)
    entity.mobRegen(mob)
>>>>>>> de3620867a (King V bug fixes)
end

return entity
