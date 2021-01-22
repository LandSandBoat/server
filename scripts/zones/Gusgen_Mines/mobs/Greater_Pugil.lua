-----------------------------------
-- Area: Gusgen Mines
--  Mob: Greater Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 682, 1, tpz.regime.type.GROUNDS)
end

return entity
