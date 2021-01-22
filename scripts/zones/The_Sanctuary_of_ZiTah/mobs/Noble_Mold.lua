-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  Mob: Noble Mold
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 115, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 116, 2, tpz.regime.type.FIELDS)
end

return entity
