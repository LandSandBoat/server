-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Ice Pot
-- KSNM: E-vase-ive Action
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ICE_ABSORB, 1000)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobEngaged = function(mob)
    local pot = mob:getID()
    for i = 1, 4 do
        DespawnMob(pot+i)
    end
    DespawnMob(pot-1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
