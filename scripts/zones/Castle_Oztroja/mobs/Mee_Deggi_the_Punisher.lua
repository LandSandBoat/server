-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Mee Deggi the Punisher
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 2] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Confirmed on retail
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 1] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- Confirmed on retail
}

return entity
