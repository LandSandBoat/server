-----------------------------------
-- Area: Ghelsba Outpost (140)
--  Mob: Orcish Stonechucker
-- Note: PH for Thousandarm Deshglesh
-----------------------------------
local ID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.THOUSANDARM_DESHGLESH, 5, 3600) -- 1 hour minimum
end

return entity
