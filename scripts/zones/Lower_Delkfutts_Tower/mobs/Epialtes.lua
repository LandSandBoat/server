-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Epialtes
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  477.096, y = -0.522, z =  52.554 }
}

entity.phList =
{
    [ID.mob.EPIALTES + 1] = ID.mob.EPIALTES, -- 432.952 -0.350 -3.719
    [ID.mob.EPIALTES + 6] = ID.mob.EPIALTES, -- 484.735 0.046 23.048
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 340)
end

return entity
