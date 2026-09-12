-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Three of Cups
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.keyItem.ORB_OF_CUPS)
end

return entity
