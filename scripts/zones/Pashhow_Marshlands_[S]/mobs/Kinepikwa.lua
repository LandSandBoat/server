-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Kinepikwa
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 507)
end
