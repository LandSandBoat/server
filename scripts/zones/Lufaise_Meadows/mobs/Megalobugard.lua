------------------------------
-- Area: Lufaise Meadows
--   NM: Megalobugard
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 439)
end
