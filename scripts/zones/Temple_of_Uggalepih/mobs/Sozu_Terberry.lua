-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Sozu Terberry
-----------------------------------
require("scripts/globals/hunts")
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
