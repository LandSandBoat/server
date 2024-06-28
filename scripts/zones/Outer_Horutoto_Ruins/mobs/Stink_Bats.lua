-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Stink Bats
-- Note: PH for Desmodont
-----------------------------------
local ID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

local desmodontPHTable =
{
    [ID.mob.DESMODONT - 2] = ID.mob.DESMODONT,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, desmodontPHTable, 10, 3600) -- 1 hour
end

return entity
