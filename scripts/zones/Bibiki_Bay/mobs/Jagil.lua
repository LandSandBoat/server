-----------------------------------
-- Area: Bibiki Bay
--  Mob: Jagil
-- Note: PH for Serra
-----------------------------------
require('scripts/globals/mobs')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- PH is the 5th Jagil entry in the zone
    local jagilId  = mob:getZone():queryEntitiesByName('Jagil')[5]:getID()
    local serraId  = mob:getZone():queryEntitiesByName('Serra')[1]:getID()
    local serraPh  =
    {
        [jagilId] = serraId, -- -348 0.001 -904
    }
    xi.mob.phOnDespawn(mob, serraPh, 10, 3600) -- 1 hour
end

return entity
