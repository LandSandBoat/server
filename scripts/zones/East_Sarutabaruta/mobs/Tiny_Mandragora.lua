-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Tiny Mandragora
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 89, 1, tpz.regime.type.FIELDS)
end

return entity
