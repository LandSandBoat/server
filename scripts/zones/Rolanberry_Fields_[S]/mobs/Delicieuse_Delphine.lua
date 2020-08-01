------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Delicieuse Delphine
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 513)
end
