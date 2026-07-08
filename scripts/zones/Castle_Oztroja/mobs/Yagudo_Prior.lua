-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Prior
-- Note: PH for Yaa Haqa the Profane
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.YAA_HAQA_THE_PROFANE, 5, 3600) -- 1 hour
end

return entity
