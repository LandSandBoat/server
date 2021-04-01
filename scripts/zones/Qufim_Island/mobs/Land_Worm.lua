-----------------------------------
-- Area: Qufim Island
--  Mob: Land Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 41, 2, xi.regime.type.FIELDS)
end

return entity
