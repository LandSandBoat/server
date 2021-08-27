-----------------------------------
-- Area: Fei'Yin
--  Mob: Shadow
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 712, 1, xi.regime.type.GROUNDS)
end

return entity
