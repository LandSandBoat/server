------------------------------
-- Area: Beadeaux
--   NM: Bi'Gho Headtaker
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 239)
end
