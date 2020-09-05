------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Balam-Quitz
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 529)
end
