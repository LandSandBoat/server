------------------------------
-- Area: Gusgen Mines
--   NM: Asphyxiated Amsel
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 235)
end
