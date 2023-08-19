-----------------------------------
-- Area: East Ronfaure
--  Mob: Wild Sheep
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 68, 1, xi.regime.type.FIELDS)
end

return entity
