------------------------------
-- Area: Jugner Forest [S]
--   NM: Vulkodlac
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 485)
end
