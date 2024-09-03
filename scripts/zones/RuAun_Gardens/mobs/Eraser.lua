-----------------------------------
-- Area: RuAun Gardens
--  Mob: Eraser (Monster)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 143, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 144, 1, xi.regime.type.FIELDS)
end

return entity
