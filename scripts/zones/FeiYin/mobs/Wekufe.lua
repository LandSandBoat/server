-----------------------------------
-- Area: Fei'Yin
--  Mob: Wekufe
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 717, 2, xi.regime.type.GROUNDS)
end

return entity
