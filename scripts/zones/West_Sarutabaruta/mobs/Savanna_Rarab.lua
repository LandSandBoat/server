-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Savanna Rarab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 27, 1, tpz.regime.type.FIELDS)
end

return entity
