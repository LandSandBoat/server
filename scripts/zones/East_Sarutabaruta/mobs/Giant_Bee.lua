-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Giant Bee
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 90, 1, xi.regime.type.FIELDS)
end

return entity
