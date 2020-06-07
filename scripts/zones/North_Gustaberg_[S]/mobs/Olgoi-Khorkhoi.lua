------------------------------
-- Area: North Gustaberg [S]
--   NM: Olgoi-Khorkhoi
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
