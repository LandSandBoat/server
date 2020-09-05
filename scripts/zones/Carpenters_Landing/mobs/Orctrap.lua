-----------------------------------
-- Area: Carpenters' Landing
--   NM: Orctrap
-- !pos 180.087 -5.484 -532.799 2
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 167)
end
