-----------------------------------
-- Area: Gusgen Mines
--  Mob: Rockmill
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 685, 2, tpz.regime.type.GROUNDS)
end

return entity
