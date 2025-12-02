-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Damselfly
-- Note: Place holder Valkurm Emperor
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 9, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 10, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, ID.mob.VALKURM_EMPEROR, 10, 3600, params) -- 1 hour
end

return entity
