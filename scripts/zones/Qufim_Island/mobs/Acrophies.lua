-----------------------------------
-- Area: Qufim Island
--  Mob: Acrophies
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 45, 1, tpz.regime.type.FIELDS)
end

return entity
