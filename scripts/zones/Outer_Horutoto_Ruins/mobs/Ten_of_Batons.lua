-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Ten of Batons
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_BATONS)
end

return entity
