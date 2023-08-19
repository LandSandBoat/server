-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Yagudo Persecutor
-- Note: PH for Naa Zeku the Unwaiting
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NAA_ZEKU_THE_UNWAITING_PH, 10, 3600) -- 1 hour
end

return entity
