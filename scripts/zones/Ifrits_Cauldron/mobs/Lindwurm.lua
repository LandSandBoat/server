------------------------------
-- Area: Ifrits Cauldron
--   NM: Lindwurm
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 401)
end
