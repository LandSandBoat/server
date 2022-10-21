-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Vanguard Vindicator
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Beaucedine/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GUNHA_WALLSTORMER_PH, 10, 1200) -- 20 minutes
end

return entity
