-----------------------------------
-- Area: Beadeaux (254)
--   NM: Bi'Gho Headtaker
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -98.611, y =  0.498, z =  71.212 }
}

entity.phList =
{
    [ID.mob.BI_GHO_HEADTAKER - 1] = ID.mob.BI_GHO_HEADTAKER, -- -98.611 0.498 71.212
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 239)
end

return entity
