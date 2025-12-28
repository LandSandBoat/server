-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Aiatar
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.AIATAR - 5] = ID.mob.AIATAR,
    [ID.mob.AIATAR - 4] = ID.mob.AIATAR,
    [ID.mob.AIATAR - 3] = ID.mob.AIATAR,
    [ID.mob.AIATAR - 2] = ID.mob.AIATAR,
    [ID.mob.AIATAR - 1] = ID.mob.AIATAR,
}

entity.onMobInitialize = function(mob)
    mob:addMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
