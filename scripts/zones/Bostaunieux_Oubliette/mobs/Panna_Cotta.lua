-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Panna Cotta
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 614, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 615, 2, xi.regime.type.GROUNDS)
end

return entity
