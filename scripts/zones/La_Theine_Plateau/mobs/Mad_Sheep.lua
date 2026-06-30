-----------------------------------
-- Area: La Theine Plateau
--  Mob: Mad Sheep
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 69, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 70, 1, xi.regime.type.FIELDS)
end

return entity
