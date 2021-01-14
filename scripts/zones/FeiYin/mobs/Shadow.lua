-----------------------------------
-- Area: Fei'Yin
--  Mob: Shadow
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 712, 1, tpz.regime.type.GROUNDS)
end

return entity
