-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Two of Cups
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.keyItem.ORB_OF_CUPS)
end

return entity
