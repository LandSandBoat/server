-----------------------------------
-- Area: RuAun Gardens
--  Mob: Ice Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 146, 1, xi.regime.type.FIELDS)
end

return entity
