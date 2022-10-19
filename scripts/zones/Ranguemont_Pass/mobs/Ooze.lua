-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Ooze
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 603, 2, xi.regime.type.GROUNDS)
end

return entity
