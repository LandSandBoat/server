-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Stygian Pugil
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 621, 2, xi.regime.type.GROUNDS)
end

return entity
