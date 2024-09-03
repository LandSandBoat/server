-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Death Wasp
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 25, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 85, 1, xi.regime.type.FIELDS)
end

return entity
