-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Voluptuous Vilma
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
-----------------------------------
local entity = {}

Blind, Bind, Paralyze, Silence, Weight, and Poison.

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local random = math.random(1,5)
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

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    DisallowRespawn(ID.mob.VOLUPTUOUS_VILMA, true)
    DisallowRespawn(ID.mob.ROSE_GARDEN_PH, false)
    GetMobByID(ID.mob.ROSE_GARDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.ROSE_GARDEN_PH))
end

return entity
