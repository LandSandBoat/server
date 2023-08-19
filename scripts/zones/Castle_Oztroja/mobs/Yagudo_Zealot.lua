-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Zealot
-- Note: PH for Yaa Haqa the Profane
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.YAA_HAQA_THE_PROFANE_PH, 5, 3600) -- 1 hours
end

return entity
