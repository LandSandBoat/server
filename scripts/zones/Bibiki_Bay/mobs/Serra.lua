------------------------------
-- Area: Bibiki Bay
--   NM: Serra
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 264)
end
