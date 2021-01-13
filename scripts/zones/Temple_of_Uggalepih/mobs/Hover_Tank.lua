-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Hover Tank
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 794, 2, tpz.regime.type.GROUNDS)
end

return entity
