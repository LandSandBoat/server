-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Troika Bats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 651, 1, xi.regime.type.GROUNDS)
end

return entity
