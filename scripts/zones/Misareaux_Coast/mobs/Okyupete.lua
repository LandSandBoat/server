------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 446)
end
