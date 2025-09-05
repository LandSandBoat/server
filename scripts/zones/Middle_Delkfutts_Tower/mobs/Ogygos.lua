-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Ogygos
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -495.000, y = -128.000, z =  19.000 }
}

entity.phList =
{
    [ID.mob.OGYGOS + 1] = ID.mob.OGYGOS, -- -503 -127.715 24
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 339)
end

return entity
