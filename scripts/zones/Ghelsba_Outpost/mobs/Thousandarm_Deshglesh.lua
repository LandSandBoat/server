-----------------------------------
-- Area: Ghelsba Outpost (140)
--   NM: Thousandarm Deshglesh
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 170)
end
