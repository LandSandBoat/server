-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Goblin Ambusher
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 57, 2, xi.regime.type.FIELDS)
end

return entity
