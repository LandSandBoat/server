------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Kirtimukha
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 523)
end
