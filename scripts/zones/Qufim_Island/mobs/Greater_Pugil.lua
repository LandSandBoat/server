-----------------------------------
-- Area: Qufim Island
--  Mob: Greater Pugil
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 43, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 44, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 45, 3, xi.regime.type.FIELDS)
end

return entity
