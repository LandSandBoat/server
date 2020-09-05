-----------------------------------
-- Area: Horlais Peak
--  Mob: Dread Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.DREAD_DRAGON_SLAYER)
end
