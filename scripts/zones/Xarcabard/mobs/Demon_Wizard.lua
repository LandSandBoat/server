-----------------------------------
-- Area: Xarcabard
--  Mob: Demon Wizard
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 55, 1, xi.regime.type.FIELDS)
end

return entity
