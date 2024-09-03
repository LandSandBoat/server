-----------------------------------
-- Area: RuAun Gardens
--  Mob: Flamingo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 142, 1, xi.regime.type.FIELDS)
end

return entity
