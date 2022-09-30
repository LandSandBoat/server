-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Vanguard Constable
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
    xi.mob.phOnDespawn(mob, ID.mob.GIBHE_FLESHFEASTER_PH, 10, 1200) -- 20 minutes
end

return entity
