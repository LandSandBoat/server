------------------------------
-- Area: Western Altepa Desert
--   NM: Picolaton
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 414)
end
