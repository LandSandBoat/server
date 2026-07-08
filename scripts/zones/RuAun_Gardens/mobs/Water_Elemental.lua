-----------------------------------
-- Area: RuAun Gardens
--  Mob: Water Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 146, 3, xi.regime.type.FIELDS)
end

return entity
