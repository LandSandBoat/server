-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Epialtes
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 340)
end
