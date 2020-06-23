-----------------------------------
-- Area: Quicksand Caves
--   NM: Proconsul XII
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 437)
end
