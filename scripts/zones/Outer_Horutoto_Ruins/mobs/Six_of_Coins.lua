-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Coins
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 665, 4, xi.regime.type.GROUNDS)
end

return entity
