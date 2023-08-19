-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Sand Hare
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 7, 2, xi.regime.type.FIELDS)
end

return entity
