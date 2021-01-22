-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Steelshell
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 723, 2, tpz.regime.type.GROUNDS)
end

return entity
