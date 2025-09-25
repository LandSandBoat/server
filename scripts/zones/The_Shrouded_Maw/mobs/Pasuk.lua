-----------------------------------
-- Area: The Shrouded Maw
-- ENM Test Your Mite
--  Mob: Pasuk
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { chance = 25, power = math.random(200, 250) })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
