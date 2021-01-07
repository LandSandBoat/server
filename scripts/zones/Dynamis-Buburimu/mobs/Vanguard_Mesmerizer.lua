-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Vanguard Mesmerizer
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Buburimu/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ELVAANSTICKER_BXAFRAFF_PH, 10, 1200) -- 20 minutes
end

return entity
