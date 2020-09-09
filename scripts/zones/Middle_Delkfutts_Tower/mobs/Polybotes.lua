-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Polybotes
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 335)
end
