-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Stag Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 38, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 39, 2, tpz.regime.type.FIELDS)
end

return entity
