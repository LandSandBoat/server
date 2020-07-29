-----------------------------------
-- Area: Beadeaux (254)
--   NM: Da'Dha Hundredmask
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 241)
end
