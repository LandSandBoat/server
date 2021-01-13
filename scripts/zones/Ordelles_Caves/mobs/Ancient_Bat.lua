-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Ancient Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 659, 1, tpz.regime.type.GROUNDS)
end

return entity
