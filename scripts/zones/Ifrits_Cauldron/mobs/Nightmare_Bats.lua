-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Nightmare Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 760, 1, tpz.regime.type.GROUNDS)
end

return entity
