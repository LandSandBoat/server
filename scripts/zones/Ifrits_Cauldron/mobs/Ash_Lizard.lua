-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Ash Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 761, 1, tpz.regime.type.GROUNDS)
end

return entity
