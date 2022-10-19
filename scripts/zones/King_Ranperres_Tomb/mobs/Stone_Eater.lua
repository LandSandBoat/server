-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Stone Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 632, 1, xi.regime.type.GROUNDS)
end

return entity
