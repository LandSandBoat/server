-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Starborer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 622, 1, xi.regime.type.GROUNDS)
end

return entity
