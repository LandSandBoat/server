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

entity.phList =
{
    [ID.mob.ZI_GHI_BONEEATER - 3] = ID.mob.ZI_GHI_BONEEATER, -- 130.386 -32.313 73.967
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 220)
    xi.magian.onMobDeath(mob, player, optParams, set{ 578 })
end

return entity
