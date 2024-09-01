-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Five of Cups
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_CUPS)
    xi.regime.checkRegime(player, mob, 664, 1, xi.regime.type.GROUNDS)
end

return entity
