-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Iron Maiden
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 795, 2, tpz.regime.type.GROUNDS)
end

return entity
