------------------------------
-- Area: Lufaise Meadows
--   NM: Flockbock
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 442)
end
