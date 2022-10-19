-----------------------------------
-- Area: Den of Rancor
--  Mob: Bullbeggar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 803, 2, xi.regime.type.GROUNDS)
end

return entity
