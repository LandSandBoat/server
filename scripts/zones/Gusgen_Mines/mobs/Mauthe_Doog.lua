-----------------------------------
-- Area: Gusgen Mines
--  Mob: Mauthe Doog
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 682, 3, tpz.regime.type.GROUNDS)
end

return entity
