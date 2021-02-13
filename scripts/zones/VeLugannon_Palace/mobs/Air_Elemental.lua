-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Air Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 748, 1, tpz.regime.type.GROUNDS)
end

return entity
