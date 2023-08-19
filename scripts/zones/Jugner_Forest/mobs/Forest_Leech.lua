-----------------------------------
-- Area: Jugner Forest
--  Mob: Forest Leech
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 11, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 12, 2, xi.regime.type.FIELDS)
end

return entity
