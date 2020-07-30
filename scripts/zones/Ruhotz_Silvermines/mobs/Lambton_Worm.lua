-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Lambton Worm
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.LAMBTON_WORM_DESEGMENTER)
end
