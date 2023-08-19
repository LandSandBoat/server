-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Coins
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 663, 4, xi.regime.type.GROUNDS)
end

return entity
