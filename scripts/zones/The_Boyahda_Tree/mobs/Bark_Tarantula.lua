-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Bark Tarantula
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 725, 2, xi.regime.type.GROUNDS)
end

return entity
