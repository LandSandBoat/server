-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Crane Fly
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 36, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 37, 2, xi.regime.type.FIELDS)
end

return entity
