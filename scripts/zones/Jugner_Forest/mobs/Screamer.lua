-----------------------------------
-- Area: Jugner Forest
--  Mob: Screamer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 58, 2, tpz.regime.type.FIELDS)
end

return entity
