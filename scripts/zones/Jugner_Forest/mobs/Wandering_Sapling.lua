-----------------------------------
-- Area: Jugner Forest
--  Mob: Wandering Sapling
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 58, 1, xi.regime.type.FIELDS)
end

return entity
