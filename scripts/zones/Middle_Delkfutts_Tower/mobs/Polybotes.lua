-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Polybotes
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -41.284, y = -63.636, z =  3.492 }
}

entity.phList =
{
    [ID.mob.POLYBOTES - 1] = ID.mob.POLYBOTES, -- Giant_Gatekeeper: -48.936 -64.114 8.575
    [ID.mob.POLYBOTES - 4] = ID.mob.POLYBOTES, -- Giant_Guard:      -59.370 -64.105 17.313
    [ID.mob.POLYBOTES + 2] = ID.mob.POLYBOTES, -- Giant_Guard:      -31, -63.713 -3
    [ID.mob.POLYBOTES + 1] = ID.mob.POLYBOTES, -- Giant_Lobber:     -42.392 -63.535 -0.946
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 335)
end

return entity
