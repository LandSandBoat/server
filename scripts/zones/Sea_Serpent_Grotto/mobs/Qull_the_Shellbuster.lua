-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Qull the Shellbuster
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 373)
end
