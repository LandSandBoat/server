-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Jolly Green
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  184.993, y =  24.499, z = -41.790 }
}

entity.phList =
{
    [ID.mob.JOLLY_GREEN - 1] = ID.mob.JOLLY_GREEN, -- 184.993 24.499 -41.790
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 212)
    xi.regime.checkRegime(player, mob, 60, 3, xi.regime.type.FIELDS)
    xi.magian.onMobDeath(mob, player, optParams, set{ 942 })
end

return entity
