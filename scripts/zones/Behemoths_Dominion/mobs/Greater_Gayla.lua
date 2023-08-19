-----------------------------------
-- Area: Behemoths Dominion
--  Mob: Greater Gayla
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 101, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 103, 1, xi.regime.type.FIELDS)
end

return entity
