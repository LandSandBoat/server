-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Zhuu Buxu the Silent
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ZHUU_BUXU_THE_SILENT - 1] = ID.mob.ZHUU_BUXU_THE_SILENT,
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
