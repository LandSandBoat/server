-----------------------------------
-- Area: Quicksand Caves
--   NM: Triarius X-XV
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 436)
end
