-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Puu Timu the Phantasmal
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.PUU_TIMU_THE_PHANTASMAL - 2] = ID.mob.PUU_TIMU_THE_PHANTASMAL, -- Vanguard_Oracle
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
