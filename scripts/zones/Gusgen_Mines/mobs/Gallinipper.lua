-----------------------------------
-- Area: Gusgen Mines
--  Mob: Gallinipper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 684, 2, xi.regime.type.GROUNDS)
end

return entity
