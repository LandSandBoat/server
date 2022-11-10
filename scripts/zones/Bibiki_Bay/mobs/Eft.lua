-----------------------------------
-- Area: Bibiki Bay
--  Mob: Eft
-- Note: PH for Intulo
-----------------------------------
require('scripts/globals/mobs')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- PH is the 10th Eft entry in the zone
    local eftId    = mob:getZone():queryEntitiesByName('Eft')[10]:getID()
    local intuloId = mob:getZone():queryEntitiesByName('Intulo')[1]:getID()
    local intuloPh =
    {
        [eftId] = intuloId, -- 480 -3 743
    }
    xi.mob.phOnDespawn(mob, intuloPh, 10, 3600) -- 1 hour
end

return entity
