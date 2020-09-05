-----------------------------------
-- Area: Beadeaux (254)
--   NM: Ga'Bhu Unvanquished
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 243)
end
