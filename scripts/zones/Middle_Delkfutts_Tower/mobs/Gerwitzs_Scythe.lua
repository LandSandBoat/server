-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Gerwitz's Scythe
-- Involved In Quest: Blade of Evil
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.SILENCERES, 95)
    mob:setMod(xi.mod.LULLABYRES, 95)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local random = math.random(1,2)
    if random == 1 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN)
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
