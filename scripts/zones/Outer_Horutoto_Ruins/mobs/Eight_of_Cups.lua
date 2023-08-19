-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Eight of Cups
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 667, 1, xi.regime.type.GROUNDS)
end

return entity
