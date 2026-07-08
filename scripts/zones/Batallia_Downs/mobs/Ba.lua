-----------------------------------
-- Area: Batallia Downs
--  Mob: Ba
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 15, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 73, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TOTTERING_TOBY, 20, 3600) -- 1 hour
end

return entity
