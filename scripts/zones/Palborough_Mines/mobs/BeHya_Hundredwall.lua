------------------------------
-- Area: Palborough Mines
--   NM: Be'Hya Hundredwall
------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 222)
end
