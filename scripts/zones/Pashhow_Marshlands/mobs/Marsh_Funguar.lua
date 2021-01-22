-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Marsh Funguar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 24, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 60, 2, tpz.regime.type.FIELDS)
end

return entity
