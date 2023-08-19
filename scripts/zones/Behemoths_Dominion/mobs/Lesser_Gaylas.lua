-----------------------------------
-- Area: Behemoths Dominion
--  Mob: Lesser Gaylas
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 101, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 102, 1, xi.regime.type.FIELDS)
end

return entity
