-----------------------------------
-- Area: Jugner Forest
--  Mob: Jugner Funguar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 13, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 14, 1, tpz.regime.type.FIELDS)
end

return entity
