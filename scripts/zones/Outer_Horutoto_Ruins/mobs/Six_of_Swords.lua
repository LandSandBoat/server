-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Swords
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_SWORDS)
    xi.regime.checkRegime(player, mob, 665, 3, xi.regime.type.GROUNDS)
end

return entity
