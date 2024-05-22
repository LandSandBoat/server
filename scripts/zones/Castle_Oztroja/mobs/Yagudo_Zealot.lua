-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Zealot
-- Note: PH for Yaa Haqa the Profane
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
local entity = {}

local yaaHaqaPHTable =
{
    [ID.mob.YAA_HAQA_THE_PROFANE - 4] = ID.mob.YAA_HAQA_THE_PROFANE, -- -24.719 -16.250 -139.678
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, yaaHaqaPHTable, 5, 3600) -- 1 hours
end

return entity
