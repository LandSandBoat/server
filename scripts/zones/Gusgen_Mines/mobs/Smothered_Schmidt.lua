------------------------------
-- Area: Gusgen Mines
--   NM: Smothered Schmidt
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 230)
end
