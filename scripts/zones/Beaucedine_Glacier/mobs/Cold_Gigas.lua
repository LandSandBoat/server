-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Cold Gigas
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 50, 1, tpz.regime.type.FIELDS)
end

return entity
