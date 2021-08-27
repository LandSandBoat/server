-----------------------------------
-- Area: Gusgen Mines
--  Mob: Greater Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 682, 1, xi.regime.type.GROUNDS)
end

return entity
