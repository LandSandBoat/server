-----------------------------------
-- Area: East Ronfaure
--  Mob: Cheval Pugil
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 64, 1, xi.regime.type.FIELDS)
end

return entity
