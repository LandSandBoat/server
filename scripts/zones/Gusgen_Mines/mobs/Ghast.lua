-----------------------------------
-- Area: Gusgen Mines
--  Mob: Ghast
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 679, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 680, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 684, 1, xi.regime.type.GROUNDS)
end

return entity
