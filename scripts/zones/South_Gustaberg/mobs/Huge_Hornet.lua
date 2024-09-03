-----------------------------------
-- Area: South Gustaberg
--  Mob: Huge Hornet
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 76, 1, xi.regime.type.FIELDS)
end

return entity
