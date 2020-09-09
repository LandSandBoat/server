-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Helldiver
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 262)
end
