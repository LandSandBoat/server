-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Two of Cups
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_CUPS)
end

return entity
