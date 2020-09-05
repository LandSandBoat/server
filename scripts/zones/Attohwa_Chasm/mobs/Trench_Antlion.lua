-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Trench Antlion
-- Note: PH for Ambusher Antlion
-----------------------------------
mixins = {require("scripts/mixins/families/antlion_ambush")}
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.AMBUSHER_ANTLION_PH, 10, 3600) -- 1 hour
end
