-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Three of Coins
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_COINS)
end

return entity
