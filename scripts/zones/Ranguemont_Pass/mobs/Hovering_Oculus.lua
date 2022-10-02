-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Hovering Oculus
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 607, 2, xi.regime.type.GROUNDS)
end

return entity
