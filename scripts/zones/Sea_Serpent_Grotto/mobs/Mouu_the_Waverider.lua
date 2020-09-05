-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Mouu the Waverider
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 380)
end
