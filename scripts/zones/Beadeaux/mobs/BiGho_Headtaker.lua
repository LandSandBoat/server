-----------------------------------
-- Area: Beadeaux (254)
--   NM: Bi'Gho Headtaker
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 239)
end
