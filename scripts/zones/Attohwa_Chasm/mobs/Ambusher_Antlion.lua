-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Ambusher Antlion
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/families/antlion_ambush")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 277)
end
