-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 28, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 29, 2, tpz.regime.type.FIELDS)
end

return entity
