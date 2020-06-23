------------------------------
-- Area: Pashhow Marshlands
--   NM: Ni'Zho Bladebender
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 214)
end
