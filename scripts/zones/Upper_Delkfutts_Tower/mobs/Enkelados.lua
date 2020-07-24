-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Enkelados
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 331)
end
