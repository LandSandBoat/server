-----------------------------------
-- Area: Ghelsba Outpost (140)
--  Mob: Orcish Grunt
-- Note: PH for Thousandarm Deshglesh
-----------------------------------
local ID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
---@type TMobEntity
local entity = {}

local thousandarmPHTable =
{
    [ID.mob.THOUSANDARM_DESHGLESH - 7] = ID.mob.THOUSANDARM_DESHGLESH, -- 98.658 -0.319 328.269
}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, thousandarmPHTable, 5, 3600) -- 1 hour minimum
end

return entity
