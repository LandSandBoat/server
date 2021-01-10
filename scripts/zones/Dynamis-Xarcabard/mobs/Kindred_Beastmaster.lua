-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Kindred Beastmaster
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MARQUIS_ANDRAS_PH, 10, 1200) -- 20 minutes
end

return entity
