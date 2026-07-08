-----------------------------------
-- Area: Jugner Forest
--  Mob: Orcish Grunt
-- Note: PH for Supplespine Mujwuj
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SUPPLESPINE_MUJWUJ, 10, 3600) -- 1 hour
end

return entity
