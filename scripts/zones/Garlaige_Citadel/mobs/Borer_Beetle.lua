-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Borer Beetle
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 704, 2, xi.regime.type.GROUNDS)
end

return entity
