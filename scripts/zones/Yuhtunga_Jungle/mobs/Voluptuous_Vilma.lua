-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Voluptuous Vilma
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
-----------------------------------
local entity = {}

local updateRegen = function(mob)
    local regen = mob:getMod(xi.mod.REGEN)

    if mob:getWeather() == xi.weather.SUNSHINE then
        if regen ~= 50 then
            mob:setMod(xi.mod.REGEN, 50)
        end
    else
        if regen ~= 0 then
            mob:setMod(xi.mod.REGEN, 0)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local random = math.random(1, 5)
    if random == 5 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT)
    elseif random == 4 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SILENCE)
    elseif random == 3 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.BLIND)
    elseif random == 2 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON)
    end
end

entity.onMobFight = function(mob, target)
    updateRegen(mob)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    DisallowRespawn(ID.mob.VOLUPTUOUS_VILMA, true)
    DisallowRespawn(ID.mob.ROSE_GARDEN_PH, false)
    GetMobByID(ID.mob.ROSE_GARDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.ROSE_GARDEN_PH))
end

return entity
