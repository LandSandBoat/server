-----------------------------------
-- Area: Cape Teriggan
--  Mob: Greater Manticore
-- Note: Place Holder for Frostmane
-----------------------------------
local ID = zones[xi.zone.CAPE_TERIGGAN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 108, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.FROSTMANE, 5, 3600) -- 1 hour
end

return entity
