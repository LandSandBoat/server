-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Covin Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 653, 1, xi.regime.type.GROUNDS)
end

return entity
