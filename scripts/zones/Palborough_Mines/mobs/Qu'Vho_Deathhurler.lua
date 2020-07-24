------------------------------
-- Area: Palborough Mines
--   NM: Qu'Vho Deathhurler
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 221)
end
