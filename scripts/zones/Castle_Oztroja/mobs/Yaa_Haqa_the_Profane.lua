-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Yaa Haqa the Profane
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.YAA_HAQA_THE_PROFANE - 4] = ID.mob.YAA_HAQA_THE_PROFANE, -- Confirmed on retail
    [ID.mob.YAA_HAQA_THE_PROFANE - 1] = ID.mob.YAA_HAQA_THE_PROFANE, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 305)
end

return entity
