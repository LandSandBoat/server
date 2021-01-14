-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Bark Tarantula
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 725, 2, tpz.regime.type.GROUNDS)
end

return entity
