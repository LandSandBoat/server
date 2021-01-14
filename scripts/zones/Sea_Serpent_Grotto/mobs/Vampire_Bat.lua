-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Vampire Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 806, 2, tpz.regime.type.GROUNDS)
end

return entity
