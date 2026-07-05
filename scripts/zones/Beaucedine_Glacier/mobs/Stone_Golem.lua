-----------------------------------
-- Area: Beaucedine Glacier (111)
--  Mob: Stone Golem
-- Note: PH for Gargantua
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GARGANTUA, 5, math.randomInt(3600, 25200)) -- 1 to 7 hours
end

return entity
