-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Yagudo Persecutor
-- Note: PH for Naa Zeku the Unwaiting
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
local entity = {}

local naaZekuPHTable =
{
    [ID.mob.NAA_ZEKU_THE_UNWAITING - 5] = ID.mob.NAA_ZEKU_THE_UNWAITING,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, naaZekuPHTable, 10, 3600) -- 1 hour
end

return entity
