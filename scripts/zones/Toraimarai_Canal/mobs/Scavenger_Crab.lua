-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Scavenger Crab
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 621, 1, xi.regime.type.GROUNDS)
end

return entity
