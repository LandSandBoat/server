-----------------------------------
-- Area: Ghelsba Outpost (140)
--  Mob: Orcish Neckchopper
-- Note: PH for Thousandarm Deshglesh
-----------------------------------
local ID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
---@type TMobEntity
local entity = {}

local thousandarmPHTable =
{
    [ID.mob.THOUSANDARM_DESHGLESH - 8] = ID.mob.THOUSANDARM_DESHGLESH, -- 94.576 -1.274 333.168
    [ID.mob.THOUSANDARM_DESHGLESH - 5] = ID.mob.THOUSANDARM_DESHGLESH, -- 85.215 -0.739 344.257
    [ID.mob.THOUSANDARM_DESHGLESH - 1] = ID.mob.THOUSANDARM_DESHGLESH, -- 123.357 -0.102 332.706
}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, thousandarmPHTable, 5, 3600) -- 1 hour minimum
end

return entity
