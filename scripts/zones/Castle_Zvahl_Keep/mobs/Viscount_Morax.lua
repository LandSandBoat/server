-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Viscount Morax
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 356)
    player:addTitle(tpz.title.HELLSBANE)
end
