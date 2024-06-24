-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Lutenist
-- Note: PH for Yaa Haqa the Profane
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
local entity = {}

local yaaHaqaPHTable =
{
    [ID.mob.YAA_HAQA_THE_PROFANE - 2] = ID.mob.YAA_HAQA_THE_PROFANE, -- -25.044 -16.250 -141.534
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, yaaHaqaPHTable, 5, 3600) -- 1 hour
end

return entity
