-----------------------------------
-- Area: Gusgen Mines
--  Mob: Aroma Fly (RSE Satchets)
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
