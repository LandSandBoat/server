-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Boribaba
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 776, 2, xi.regime.type.GROUNDS)
end

return entity
