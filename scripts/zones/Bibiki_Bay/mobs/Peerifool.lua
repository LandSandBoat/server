-----------------------------------
-- Area: Bibiki Bay
--  mob: Peerifool
--  Quest: One Good Deed?
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLEEP, { chance = 100 })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
