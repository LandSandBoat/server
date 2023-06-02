-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Chigoe
-----------------------------------
mixins = { require("scripts/mixins/families/chigoe") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 30)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.ATTP, -80)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { power = 5, chance = 100, })
end

entity.onMobDeath = function(mob, player, optParams)
    -- Handled in The_Prankster.lua
end

return entity
