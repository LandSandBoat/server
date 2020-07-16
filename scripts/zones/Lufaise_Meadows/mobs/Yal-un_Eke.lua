------------------------------
-- Area: Lufaise Meadows
--   NM: Yal-un Eke
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 440)
end
