-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Goblin Digger
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 57, 2, xi.regime.type.FIELDS)
end

return entity
