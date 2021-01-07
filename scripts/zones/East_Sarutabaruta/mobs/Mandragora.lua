-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Mandragora
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 89, 1, tpz.regime.type.FIELDS)
end

return entity
