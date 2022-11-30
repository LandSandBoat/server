-----------------------------------
-- Area: Bibiki Bay
--  Mob: Tartarus Eft
-- Note: PH for Splacknuck
-----------------------------------
require('scripts/globals/mobs')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- PH is the 2nd Tartarus Eft entry in the zone
    local eftId        = mob:getZone():queryEntitiesByName('Tartarus_Eft')[2]:getID()
    local splacknuckId = mob:getZone():queryEntitiesByName('Splacknuck')[1]:getID()
    local splacknuckPh =
    {
        [eftId] = splacknuckId, -- -348 0.001 -904
    }
    xi.mob.phOnDespawn(mob, splacknuckPh, 10, 3600) -- 1 hour
end

return entity
