-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Buburimboo
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end;
