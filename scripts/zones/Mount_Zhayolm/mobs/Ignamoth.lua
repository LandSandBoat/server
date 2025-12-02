-----------------------------------
-- Area: Mount Zhayolm
--   NM: Ignamoth
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -557.152, y = -14.000, z =  278.249 }
}

entity.phList =
{
    [ID.mob.IGNAMOTH - 2] = ID.mob.IGNAMOTH, -- -567.6 -15.35 252.201
    [ID.mob.IGNAMOTH - 1] = ID.mob.IGNAMOTH, -- -544.3 -14.8 262.992
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
    mob:setMod(xi.mod.REGAIN, 200)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { duration = 60 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 457)
end

return entity
