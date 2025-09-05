-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Hippolytos
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  339.212, y = -16.099, z =  16.733 }
}

entity.phList =
{
    [ID.mob.HIPPOLYTOS + 3] = ID.mob.HIPPOLYTOS, -- Giant Sentry:     346.244 -16.126 10.373
    [ID.mob.HIPPOLYTOS + 1] = ID.mob.HIPPOLYTOS, -- Giant Gatekeeper: 337.079 -16.1 17.386
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 341)
end

return entity
