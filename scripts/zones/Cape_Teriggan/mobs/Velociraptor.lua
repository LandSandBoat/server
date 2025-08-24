-----------------------------------
-- Area: Cape Teriggan
--  Mob: Velociraptor
-- Note: Place holder Killer Jonny
-----------------------------------
local ID = zones[xi.zone.CAPE_TERIGGAN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 106, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 107, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    xi.mob.phOnDespawn(mob, ID.mob.KILLER_JONNY, 15, utils.hours(2), params)
end

return entity
