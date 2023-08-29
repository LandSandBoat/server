-----------------------------------
-- Area: Xarcabard
--   NM: Biast
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR, { chance = 7 })
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    SetServerVariable('[POP]Biast', os.time() + 75600) -- 21 hour
    DisallowRespawn(mob:getID()-1, false)
    GetMobByID(mob:getID()-1):setRespawnTime(GetMobRespawnTime(mob:getID()-1))
end

return entity
