-----------------------------------
-- Area: Qufim Island
--  Mob: Atkorkamuy
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobFight = function(mob, target)
    -- Todo: verify it actually has STP at all, by checking tp gains on retail (could be different mechanism)
    mob:setMod(xi.mod.STORETP, 40 - (mob:getHPP() / (100 / 40)))
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 310)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
