------------------------------
-- Area: North Gustaberg [S]
--   NM: Peaseblossom
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 501)
end
