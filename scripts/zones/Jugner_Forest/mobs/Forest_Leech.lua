-----------------------------------
-- Area: Jugner Forest
--  Mob: Forest Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 11, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 12, 2, tpz.regime.type.FIELDS)
end

return entity
