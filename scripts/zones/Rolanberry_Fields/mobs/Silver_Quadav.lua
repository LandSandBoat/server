-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Silver Quadav
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 87, 2, tpz.regime.type.FIELDS)
end

return entity
