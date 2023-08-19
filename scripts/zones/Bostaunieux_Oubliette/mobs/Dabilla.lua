-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Dabilla
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 612, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 614, 1, xi.regime.type.GROUNDS)
end

return entity
