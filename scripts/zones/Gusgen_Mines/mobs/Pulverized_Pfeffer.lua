------------------------------
-- Area: Gusgen Mines
--   NM: Pulverized Pfeffer
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
