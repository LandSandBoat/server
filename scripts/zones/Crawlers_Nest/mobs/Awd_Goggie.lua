-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Awd Goggie
-- !pos -253.026 -1.867 253.055 197
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.BOGEYDOWNER)
end
