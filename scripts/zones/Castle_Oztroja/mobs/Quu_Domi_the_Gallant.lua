-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Quu Domi the Gallant
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.QUU_DOMI_THE_GALLANT - 3] = ID.mob.QUU_DOMI_THE_GALLANT, -- Confirmed on retail
    [ID.mob.QUU_DOMI_THE_GALLANT - 2] = ID.mob.QUU_DOMI_THE_GALLANT, -- Confirmed on retail
}

return entity
