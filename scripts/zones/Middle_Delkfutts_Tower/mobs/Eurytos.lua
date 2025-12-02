-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Eurytos
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  20.000, y = -47.000, z =  94.000 }
}

entity.phList =
{
    [ID.mob.EURYTOS - 8] = ID.mob.EURYTOS, -- 27 -47 101
    [ID.mob.EURYTOS - 3] = ID.mob.EURYTOS, -- 11 -47 99
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 334)
end

return entity
