------------------------------
-- Area: Yhoator Jungle
--   NM: Edacious Opo-opo
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
