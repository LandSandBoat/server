-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Death Wasp
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 25, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 85, 1, tpz.regime.type.FIELDS)
end

return entity
