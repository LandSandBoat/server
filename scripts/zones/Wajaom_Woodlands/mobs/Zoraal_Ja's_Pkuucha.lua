------------------------------
-- Area: Wajaom Woodlands
--   NM: Zoraal Ja's Pkuucha
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 447)
end
