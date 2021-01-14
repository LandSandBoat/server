-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Processionaire
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 724, 1, tpz.regime.type.GROUNDS)
end

return entity
