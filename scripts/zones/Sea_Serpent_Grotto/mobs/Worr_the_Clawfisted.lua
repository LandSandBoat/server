-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Worr the Clawfisted
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 381)
end
