-----------------------------------
-- Area: Gusgen Mines
--  Mob: Wendigo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 679, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 680, 2, tpz.regime.type.GROUNDS)
end

return entity
