-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Two of Coins
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.keyItem.ORB_OF_COINS)
end

return entity
