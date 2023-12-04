-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Two of Batons
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_BATONS)
end

return entity
