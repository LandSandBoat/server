-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Brutal Sheep
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 10, 1, xi.regime.type.FIELDS)
end

return entity
