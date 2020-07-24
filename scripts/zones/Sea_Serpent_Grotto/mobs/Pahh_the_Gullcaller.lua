-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Pahh the Gullcaller
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 375)
end
