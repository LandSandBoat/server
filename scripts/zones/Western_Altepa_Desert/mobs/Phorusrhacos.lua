-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Phorusrhacos
-- Note: PH for Picolaton
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PICOLATON, 10, 6400)
end

return entity
