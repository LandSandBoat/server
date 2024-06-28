-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Cups
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_CUPS)
    xi.regime.checkRegime(player, mob, 663, 1, xi.regime.type.GROUNDS)
end

return entity
