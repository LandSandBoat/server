-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Carrion Crow
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 93, 1, tpz.regime.type.FIELDS)
end

return entity
