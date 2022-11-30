-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Axe
-- !pos -51 0.1 3 193
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.ACC, 1000) -- It should never miss
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
