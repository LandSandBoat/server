-----------------------------------
-- Area: North Gustaberg
--  Mob: Tunnel Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 16, 1, tpz.regime.type.FIELDS)
end

return entity
