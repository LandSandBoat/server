-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Carrion Crow
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 93, 1, xi.regime.type.FIELDS)
end

return entity
