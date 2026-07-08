-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Aiatar
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -81.967, y = 0.246, z = 751.067 },
}

entity.phList =
{
    [ID.mob.AIATAR - 1] = ID.mob.AIATAR, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
