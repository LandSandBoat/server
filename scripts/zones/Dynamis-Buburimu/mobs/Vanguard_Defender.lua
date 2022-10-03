-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Vanguard Defender
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
    xi.mob.phOnDespawn(mob, ID.mob.TEZHA_IRONCLAD_PH, 10, 1200) -- 20 minutes
end

return entity
