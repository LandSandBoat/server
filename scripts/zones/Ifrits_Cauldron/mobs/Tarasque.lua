------------------------------
-- Area: Ifrits Cauldron
--   NM: Tarasque
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 403)
end
