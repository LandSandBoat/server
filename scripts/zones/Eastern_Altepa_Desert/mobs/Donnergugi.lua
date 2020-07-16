------------------------------
-- Area: Eastern Altepa Desert
--   NM: Donnergugi
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 410)
end
