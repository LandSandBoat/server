-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Vanguard Oracle
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

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BAA_DAVA_THE_BIBLIOPHAGE_PH, 10, 1200) -- 20 minutes
end

return entity
