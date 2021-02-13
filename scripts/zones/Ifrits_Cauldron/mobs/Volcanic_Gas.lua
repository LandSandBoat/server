-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Volcanic Gas
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 755, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 756, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 757, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 758, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 759, 1, tpz.regime.type.GROUNDS)
end

return entity
