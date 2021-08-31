-----------------------------------
-- Area: Qufim Island
--  Mob: Seeker Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 42, 2, xi.regime.type.FIELDS)
end

return entity
