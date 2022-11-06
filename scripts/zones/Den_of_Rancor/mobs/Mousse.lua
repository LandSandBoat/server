-----------------------------------
-- Area: Den of Rancor
--  Mob: Mousse
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 797, 2, xi.regime.type.GROUNDS)
end

return entity
