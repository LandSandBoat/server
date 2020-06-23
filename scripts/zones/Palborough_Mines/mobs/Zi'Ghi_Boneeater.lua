------------------------------
-- Area: Palborough Mines
--   NM: Zi'Ghi Boneeater
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 220)
end
