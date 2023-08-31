-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Vanguard Sentinel
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
    xi.mob.phOnDespawn(mob, ID.mob.XAA_CHAU_THE_ROCTALON_PH, 10, 1200) -- 20 minutes
end

return entity
