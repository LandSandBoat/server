-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Ogre Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 638, 2, tpz.regime.type.GROUNDS)
end
