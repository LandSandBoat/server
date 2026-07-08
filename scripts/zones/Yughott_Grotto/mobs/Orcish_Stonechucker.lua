-----------------------------------
-- Area: Yughott Grotto (142)
--  Mob: Orcish Stonechucker
-- Note: PH for Ashmaker Gotblut
-----------------------------------
local ID = zones[xi.zone.YUGHOTT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ASHMAKER_GOTBLUT, 5, 3600) -- 1 hour minimum
end

return entity
