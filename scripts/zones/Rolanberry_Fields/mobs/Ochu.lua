-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Ochu
-- Note: PH for Drooling Daisy
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 88, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DROOLING_DAISY, 10, 3600) -- 1 hour
end

return entity
