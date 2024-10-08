-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Nine of Batons
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_BATONS)
    xi.regime.checkRegime(player, mob, 668, 2, xi.regime.type.GROUNDS)
end

return entity
