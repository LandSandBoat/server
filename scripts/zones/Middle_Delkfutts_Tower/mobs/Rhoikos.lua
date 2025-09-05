-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Rhoikos
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -378.000, y = -111.000, z =  47.000 }
}

entity.phList =
{
    [ID.mob.RHOIKOS - 1]  = ID.mob.RHOIKOS, -- -402 -111.924 46
    [ID.mob.RHOIKOS + 11] = ID.mob.RHOIKOS, -- -389.084 -111.532 35.374
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 338)
end

return entity
