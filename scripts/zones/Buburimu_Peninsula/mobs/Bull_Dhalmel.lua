-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Bull Dhalmel
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 34, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 35, 2, xi.regime.type.FIELDS)
end

return entity
