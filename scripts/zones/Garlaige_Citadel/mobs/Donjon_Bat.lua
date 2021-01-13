-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Donjon Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 709, 1, tpz.regime.type.GROUNDS)
end

return entity
