-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Tsaagan
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 39, 1, xi.regime.type.FIELDS)
end

return entity
