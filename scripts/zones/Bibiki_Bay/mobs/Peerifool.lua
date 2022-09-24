-----------------------------------
-- Area: Bibiki Bay
--  mob: Peerifool
--  Quest: One Good Deed?
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLEEP, { chance = 100 })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
