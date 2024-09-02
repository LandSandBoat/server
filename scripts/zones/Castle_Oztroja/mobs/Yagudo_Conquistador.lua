-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Conquistador
-- Note: PH for Yaa Haqa the Profane
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

local yaaHaqaPHTable =
{
    [ID.mob.YAA_HAQA_THE_PROFANE - 3] = ID.mob.YAA_HAQA_THE_PROFANE, -- -22.395 -16.250 -139.341
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, yaaHaqaPHTable, 5, 3600) -- 1 hour
end

return entity
