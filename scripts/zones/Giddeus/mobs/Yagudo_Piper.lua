-----------------------------------
-- Area: Giddeus (145)
--  Mob: Yagudo Piper
-- Note: PH for Vuu Puqu the Beguiler
-----------------------------------
local ID = zones[xi.zone.GIDDEUS]
-----------------------------------
local entity = {}

local vuuPuquPHTable =
{
    [ID.mob.VUU_PUQU_THE_BEGUILER - 1] = ID.mob.VUU_PUQU_THE_BEGUILER, -- -23.973 0.459 -399.155
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, vuuPuquPHTable, 15, 900) -- 15 minutes
end

return entity
