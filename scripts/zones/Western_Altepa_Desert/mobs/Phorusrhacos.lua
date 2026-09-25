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
    -- Picolaton PH has a varied spawn location
    if mob:getID() == (ID.mob.PICOLATON - 1) then
    end

    xi.mob.phOnDespawn(mob, ID.mob.PICOLATON, 10, 6400)
end

return entity
