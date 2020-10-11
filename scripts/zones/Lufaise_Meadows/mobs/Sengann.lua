-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Sengann
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/fomor_hate")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 441)
end
