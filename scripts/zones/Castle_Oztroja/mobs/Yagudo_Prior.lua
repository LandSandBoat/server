-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Prior
-- Note: PH for Yaa Haqa the Profane
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
local entity = {}

local yaaHaqaPHTable =
{
    [ID.mob.YAA_HAQA_THE_PROFANE - 1] = ID.mob.YAA_HAQA_THE_PROFANE, -- -32.302 -16.250 -139.169
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, yaaHaqaPHTable, 5, 3600) -- 1 hour
end

return entity
