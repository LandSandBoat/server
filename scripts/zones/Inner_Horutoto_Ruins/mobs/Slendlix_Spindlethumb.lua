-----------------------------------
-- Area: Inner Horutoto Ruins
--   NM: Slendlix Spindlethumb
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -238.000, y = -0.500, z = -167.000 }
}

entity.phList =
{
    [ID.mob.SLENDLIX_SPINDLETHUMB - 27] = ID.mob.SLENDLIX_SPINDLETHUMB, -- -238.315 -0.002 -179.249
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 289)
    xi.magian.onMobDeath(mob, player, optParams, set{ 430 })
end

return entity
