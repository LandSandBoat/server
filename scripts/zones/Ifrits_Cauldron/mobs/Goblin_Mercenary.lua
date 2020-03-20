-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Goblin Mercenary
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 757, 1, tpz.regime.type.GROUNDS)
end
