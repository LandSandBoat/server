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
    [ID.mob.ASHMAKER_GOTBLUT - 4] = ID.mob.ASHMAKER_GOTBLUT, -- Confirmed on retail
    [ID.mob.ASHMAKER_GOTBLUT - 3] = ID.mob.ASHMAKER_GOTBLUT, -- Confirmed on retail
}

return entity
