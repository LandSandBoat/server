-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Mourioche
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 720, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 721, 1, xi.regime.type.GROUNDS)
end

return entity
