-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Makara
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 764, 2, xi.regime.type.GROUNDS)
end

return entity
