-----------------------------------
-- Area: Xarcabard
--   NM: Biast
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 2000)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR, { chance = 10 })
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    SetServerVariable('[POP]Biast', GetSystemTime() + 75600) -- 21 hour
    DisallowRespawn(mob:getID()-1, false)
    GetMobByID(mob:getID()-1):setRespawnTime(GetMobRespawnTime(mob:getID()-1))
end

return entity
