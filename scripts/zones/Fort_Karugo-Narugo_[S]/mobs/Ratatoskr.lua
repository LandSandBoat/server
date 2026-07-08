-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Ratatoskr
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  24.514, y = -70.143, z = -220.559 }
}

entity.phList =
{
    [ID.mob.RATATOSKR - 3] = ID.mob.RATATOSKR,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 522)
    xi.magian.onMobDeath(mob, player, optParams, set{ 155, 369, 583 })
end

return entity
