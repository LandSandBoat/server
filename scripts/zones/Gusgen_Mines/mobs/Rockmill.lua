-----------------------------------
-- Area: Gusgen Mines
--  Mob: Rockmill
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 685, 2, xi.regime.type.GROUNDS)
end

return entity
