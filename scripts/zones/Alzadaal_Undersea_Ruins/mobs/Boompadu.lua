------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Boompadu
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 476)
end
