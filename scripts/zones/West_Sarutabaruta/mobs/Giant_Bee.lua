-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Giant Bee
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 61, 2, tpz.regime.type.FIELDS)
end

return entity
