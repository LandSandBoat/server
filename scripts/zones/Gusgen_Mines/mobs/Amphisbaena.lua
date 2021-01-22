-----------------------------------
-- Area: Gusgen Mines
--  Mob: Amphisbaena
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 682, 2, tpz.regime.type.GROUNDS)
end

return entity
