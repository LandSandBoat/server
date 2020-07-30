-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Voll the Sharkfinned
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 378)
end
