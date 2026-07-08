-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Boggart
-- Note: Place holder Nocuous Weapon
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 650, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NOCUOUS_WEAPON, 10, 1, {}) -- True Lottery
end

return entity
