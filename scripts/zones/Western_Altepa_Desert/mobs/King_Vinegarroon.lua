-----------------------------------
-- Area: Western Altepa Desert
--   NM: King Vinegarroon
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
-----------------------------------
local entity = {}

local updateRegen = function(mob)
    local hour = VanadielHour()
    local regen = mob:getMod(xi.mod.REGEN)

    if hour > 3 and hour < 20 then -- daytime between 4:00 and 20:00
        if regen ~= 125 then
            mob:setMod(xi.mod.REGEN, 125)
        end
    else
        if regen ~= 250 then
            mob:setMod(xi.mod.REGEN, 250)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY, { chance = 100 })
end

entity.onMobDisengage = function(mob, weather)
    if
        not (mob:getWeather() == xi.weather.DUST_STORM or
        mob:getWeather() == xi.weather.SAND_STORM)
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VINEGAR_EVAPORATOR)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local nextDrawIn = mob:getLocalVar("[Draw-In]WaitTime")

    -- Every time KV performs a TP move, he will draw in either his target or the entire alliance randomly
    if
        (skill:getID() == 354 or skill:getID() == 355 or skill:getID() == 722 or skill:getID() == 723) and
        os.time() > nextDrawIn
    then
        local chance = math.random(1, 2)
        if chance == 1 then
            mob:triggerDrawIn(mob, true, 1, nil, target, true)
        else
            mob:triggerDrawIn(mob, false, 1, nil, target, true)
        end

        -- KV always does an AOE TP move followed by a single target TP move
        mob:useMobAbility(({ 353, 350, 720 })[math.random(1, 3)])
        mob:setLocalVar("[Draw-In]WaitTime", os.time() + 1)
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, 75600) -- 21 hours
    DisallowRespawn(mob:getID(), true)
end

entity.onMobFight = function(mob, target)
    local drawInTableNorth =
    {
        condition1 = target:getZPos() > -540,
        position   = { target:getXPos(), target:getYPos(), -542, target:getRotPos() },
    }
    local drawInTableSouth =
    {
        condition1 = target:getXPos() < -350,
        position   = { -348, target:getYPos(), target:getZPos(), target:getRotPos() },
    }

    updateRegen(mob)
    utils.arenaDrawIn(mob, target, drawInTableNorth)
    utils.arenaDrawIn(mob, target, drawInTableSouth)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)

    if
        not (mob:getWeather() == xi.weather.DUST_STORM or
        mob:getWeather() == xi.weather.SAND_STORM)
    then
        DespawnMob(mob:getID())
    end
end

return entity
