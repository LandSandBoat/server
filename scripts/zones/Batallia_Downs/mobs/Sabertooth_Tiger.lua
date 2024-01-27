-----------------------------------
-- Area: Batallia Downs
--  Mob: Sabertooth Tiger
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 74, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 75, 1, xi.regime.type.FIELDS)
end

return entity
