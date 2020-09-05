-----------------------------------
-- Area: Beadeaux (254)
--   NM: Ge'Dha Evileye
-- !pos -238 1 -202 254
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 240)
end
