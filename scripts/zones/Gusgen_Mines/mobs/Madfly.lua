-----------------------------------
-- Area: Gusgen Mines
--  Mob: Madfly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 686, 2, xi.regime.type.GROUNDS)
end

return entity
