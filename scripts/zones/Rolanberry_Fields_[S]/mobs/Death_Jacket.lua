-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Death Jacket
-- Note: PH for Erle
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local phTable =
    {
        [ID.mob.ERLE - 6] = ID.mob.ERLE,
    }

    xi.mob.phOnDespawn(mob, phTable, 10, 5400) -- 1.5 hour
end

return entity
