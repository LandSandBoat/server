-----------------------------------
-- Area: Yughott Grotto (142)
--   NM: Ashmaker Gotblut
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.YUGHOTT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ASHMAKER_GOTBLUT - 3]  = ID.mob.ASHMAKER_GOTBLUT,
    [ID.mob.ASHMAKER_GOTBLUT - 6]  = ID.mob.ASHMAKER_GOTBLUT,
    [ID.mob.ASHMAKER_GOTBLUT - 7]  = ID.mob.ASHMAKER_GOTBLUT,
    [ID.mob.ASHMAKER_GOTBLUT - 12] = ID.mob.ASHMAKER_GOTBLUT,
    [ID.mob.ASHMAKER_GOTBLUT - 19] = ID.mob.ASHMAKER_GOTBLUT,
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
