-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Two of Swords
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_SWORDS)
end

return entity
