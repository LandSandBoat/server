-----------------------------------
-- Area: Qufim Island
--   NM: Slippery Sucker
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  16.350, y = -21.300, z = -25.500 }
}

entity.phList =
{
    [ID.mob.SLIPPERY_SUCKER - 11] = ID.mob.SLIPPERY_SUCKER, -- Giant_Trapper
    [ID.mob.SLIPPERY_SUCKER - 13] = ID.mob.SLIPPERY_SUCKER, -- Giant_Ranger
    [ID.mob.SLIPPERY_SUCKER - 9] = ID.mob.SLIPPERY_SUCKER, -- Giant_Hunter
    [ID.mob.SLIPPERY_SUCKER - 12] = ID.mob.SLIPPERY_SUCKER, -- Giant_Ascetic
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 308)
    xi.magian.onMobDeath(mob, player, optParams, set{ 218 })
end

return entity
