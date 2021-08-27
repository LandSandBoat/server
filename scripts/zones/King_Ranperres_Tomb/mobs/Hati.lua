-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Hati
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 637, 2, xi.regime.type.GROUNDS)
end

return entity
