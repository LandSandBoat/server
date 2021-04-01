-----------------------------------
-- Area: East Ronfaure
--  Mob: Forest Hare
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 66, 1, xi.regime.type.FIELDS)
end

return entity
