-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Blackwater Pugil
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 624, 1, xi.regime.type.GROUNDS)
end

return entity
