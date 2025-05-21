-----------------------------------
-- Area: Ghelsba Outpost (140)
--  Mob: Orcish Stonechucker
-- Note: PH for Thousandarm Deshglesh
-----------------------------------
local ID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
---@type TMobEntity
local entity = {}

local thousandarmPHTable =
{
    [ID.mob.THOUSANDARM_DESHGLESH - 9] = ID.mob.THOUSANDARM_DESHGLESH, -- 80.000 -0.249 328.000
    [ID.mob.THOUSANDARM_DESHGLESH - 6] = ID.mob.THOUSANDARM_DESHGLESH, -- 96.763 -0.047 319.781
    [ID.mob.THOUSANDARM_DESHGLESH - 2] = ID.mob.THOUSANDARM_DESHGLESH, -- 82.000 -0.500 366.000
}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, thousandarmPHTable, 5, 3600) -- 1 hour minimum
end

return entity
