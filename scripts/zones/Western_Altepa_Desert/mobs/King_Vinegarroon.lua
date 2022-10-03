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
    mob:setMobMod(xi.mobMod.DRAW_IN, 2)
end

entity.onMobDrawIn = function(mob, target)
    -- todo make him use AoE tp move
    mob:addTP(3000)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY, { chance = 100 })
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

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VINEGAR_EVAPORATOR)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

entity.mobRegen = function(mob)
    local hour = VanadielHour()

    if hour >= 6 and hour <= 20 then
        mob:setMod(xi.mod.REGEN, 125)
    else
        mob:setMod(xi.mod.REGEN, 250)
    end
end

entity.onMobFight = function(mob, target)
    entity.mobRegen(mob)
end

return entity
