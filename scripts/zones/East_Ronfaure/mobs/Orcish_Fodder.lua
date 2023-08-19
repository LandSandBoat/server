-----------------------------------
-- Area: East Ronfaure
--  Mob: Orcish Fodder
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 67, 1, xi.regime.type.FIELDS)
end

return entity
