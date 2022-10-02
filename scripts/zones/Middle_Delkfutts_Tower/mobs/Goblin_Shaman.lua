-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Goblin Shaman
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 782, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 784, 1, xi.regime.type.GROUNDS)
end

return entity
