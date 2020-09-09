-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Yilbegan
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.YILBEGAN_HIDEFLAYER)
end
