-----------------------------------
-- Area: Davoi
--   NM: Tigerbane Bakdak
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 193)
end
