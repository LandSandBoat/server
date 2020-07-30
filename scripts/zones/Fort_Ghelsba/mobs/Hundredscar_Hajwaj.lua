-----------------------------------
-- Area: Fort Ghelsba
--   NM: Hundredscar Hajwaj
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 172)
end
