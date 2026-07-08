-----------------------------------
-- Area: La Theine Plateau
--  Mob: Grass Funguar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 71, 2, xi.regime.type.FIELDS)
end

return entity
