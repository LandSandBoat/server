-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Eight of Swords
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_SWORDS)
    xi.regime.checkRegime(player, mob, 667, 3, xi.regime.type.GROUNDS)
end

return entity
