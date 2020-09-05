-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Zealot
-- Note: PH for Yaa Haqa the Profane
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.YAA_HAQA_THE_PROFANE_PH, 5, 3600) -- 1 hours
end
