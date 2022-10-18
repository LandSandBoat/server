-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Steelshell
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 723, 2, xi.regime.type.GROUNDS)
end

return entity
