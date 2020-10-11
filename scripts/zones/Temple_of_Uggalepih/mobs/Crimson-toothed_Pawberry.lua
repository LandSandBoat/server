-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Crimson-toothed Pawberry
-----------------------------------
require("scripts/globals/hunts")
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 392)
end
