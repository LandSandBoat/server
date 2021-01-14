-----------------------------------
-- Area: Fei'Yin
--  Mob: Hellish Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 716, 2, tpz.regime.type.GROUNDS)
end

return entity
