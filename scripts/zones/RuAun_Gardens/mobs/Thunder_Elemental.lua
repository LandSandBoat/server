-----------------------------------
-- Area: RuAun Gardens
--  Mob: Thunder Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 145, 3, xi.regime.type.FIELDS)
end

return entity
