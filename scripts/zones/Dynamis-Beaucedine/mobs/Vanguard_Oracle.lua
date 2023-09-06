-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Vanguard Oracle
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PUU_TIMU_THE_PHANTASMAL_PH, 10, 1200) -- 20 minutes
end

return entity
