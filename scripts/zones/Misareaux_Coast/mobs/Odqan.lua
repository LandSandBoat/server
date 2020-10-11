------------------------------
-- Area: Misareaux Coast
--   NM: Odqan
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 443)
end
