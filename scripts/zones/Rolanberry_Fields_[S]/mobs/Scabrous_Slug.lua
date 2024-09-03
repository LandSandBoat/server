-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Scabrous Slug
-- Note: PH for Dyinyanga
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
        [ID.mob.DYINYINGA - 1] = ID.mob.DYINYINGA,
    }

    xi.mob.phOnDespawn(mob, phTable, 10, 3600) -- 1 hour
end

return entity
