-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Fetor Bats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 669, 1, xi.regime.type.GROUNDS)
end

return entity
