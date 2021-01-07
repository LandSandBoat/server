-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Tsaagan
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 39, 1, tpz.regime.type.FIELDS)
end

return entity
