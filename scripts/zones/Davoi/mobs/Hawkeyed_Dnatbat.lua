-----------------------------------
-- Area: Davoi
--   NM: Hawkeyed Dnatbat
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 192)
end
