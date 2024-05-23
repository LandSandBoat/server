-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Cups
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_CUPS)
    xi.regime.checkRegime(player, mob, 665, 1, xi.regime.type.GROUNDS)
end

return entity
