------------------------------
-- Area: Halvung
--   NM: Big Bomb
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 466)
end
