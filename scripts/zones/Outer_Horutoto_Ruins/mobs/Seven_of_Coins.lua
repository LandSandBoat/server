-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Seven of Coins
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_COINS)
    xi.regime.checkRegime(player, mob, 666, 4, xi.regime.type.GROUNDS)
end

return entity
