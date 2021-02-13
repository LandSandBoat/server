-----------------------------------
-- Area: Fei'Yin
--  Mob: Killing Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 716, 1, tpz.regime.type.GROUNDS)
end

return entity
