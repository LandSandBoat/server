-----------------------------------
-- Area: Fei'Yin
--  Mob: Vampire Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 711, 1, tpz.regime.type.GROUNDS)
end

return entity
