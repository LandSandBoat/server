-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Leecher
-- Note: PH for Slendlix Spindlethumb
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SLENDLIX_SPINDLETHUMB, 10, 3600) -- 1 hour
end

return entity
