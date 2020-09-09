------------------------------
-- Area: Den of Rancor
--   NM: Friar Rush
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 394)
end
