-----------------------------------
-- Area: South Gustaberg
--   NM: Bubbly Bernie
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 80, 2, tpz.regime.type.FIELDS)
end

return entity
