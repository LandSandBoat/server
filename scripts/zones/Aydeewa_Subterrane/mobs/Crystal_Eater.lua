------------------------------
-- Area: Aydeewa Subterrane
--   NM: Crystal Eater
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 463)
end
