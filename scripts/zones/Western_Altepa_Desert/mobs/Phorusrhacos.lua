-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Phorusrhacos
-- Note: PH for Picolaton
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Picolaton PH has a varied spawn location
    if mob:getID() == (ID.mob.PICOLATON - 1) then
        UpdateNMSpawnPoint(mob:getID())
    end

    xi.mob.phOnDespawn(mob, ID.mob.PICOLATON, 10, 6400)
end

return entity
