-----------------------------------
-- Area: West Ronfaure
--  Mob: Tunnel Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
end

return entity
