-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Robber Crab
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 809, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 810, 1, xi.regime.type.GROUNDS)
end

return entity
