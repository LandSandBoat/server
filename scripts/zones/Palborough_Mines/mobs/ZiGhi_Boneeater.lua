-----------------------------------
-- Area: Palborough Mines
--   NM: Zi'Ghi Boneeater
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  138.839, y = -32.500, z =  72.357 },
    { x =  138.747, y = -32.000, z =  88.684 },
    { x =  128.329, y = -32.000, z =  86.223 },
    { x =  127.134, y = -32.000, z =  70.341 }
}

entity.phList =
{
    [ID.mob.ZI_GHI_BONEEATER - 3] = ID.mob.ZI_GHI_BONEEATER, -- 130.386 -32.313 73.967
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 220)
    xi.magian.onMobDeath(mob, player, optParams, set{ 578 })
end

return entity
