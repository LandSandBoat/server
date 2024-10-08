-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Water Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 748, 1, xi.regime.type.GROUNDS)
end

return entity
