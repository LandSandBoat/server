-----------------------------------
-- Area: Quicksand Caves
--   NM: Tribunus VII-I
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 434)
end
