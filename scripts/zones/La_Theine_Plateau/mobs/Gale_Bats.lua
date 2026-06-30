-----------------------------------
-- Area: La Theine Plateau
--  Mob: Gale Bats
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 71, 1, xi.regime.type.FIELDS)
end

return entity
