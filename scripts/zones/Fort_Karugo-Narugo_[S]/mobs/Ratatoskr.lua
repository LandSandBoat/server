------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Ratatoskr
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
