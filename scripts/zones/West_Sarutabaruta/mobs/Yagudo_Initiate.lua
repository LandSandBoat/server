-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Yagudo Initiate
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 29, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 61, 1, tpz.regime.type.FIELDS)
end

return entity
