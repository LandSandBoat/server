-----------------------------------
-- Area: Qufim Island
--  Mob: Atkorkamuy
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -341.691, y = -21.000, z =  39.305 },
    { x = -338.898, y = -21.028, z =  45.620 },
    { x = -286.022, y = -21.102, z =  75.400 },
    { x = -226.756, y = -20.846, z =  32.378 },
    { x = -202.110, y = -20.310, z = -10.470 }
}

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
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
