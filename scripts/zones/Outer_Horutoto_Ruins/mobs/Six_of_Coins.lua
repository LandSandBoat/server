-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Coins
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_COINS)
    xi.regime.checkRegime(player, mob, 665, 4, xi.regime.type.GROUNDS)
end

return entity
