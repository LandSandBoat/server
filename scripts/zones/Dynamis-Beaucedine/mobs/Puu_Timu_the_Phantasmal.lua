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

entity.spawnPoints =
{
    { x =  187.217, y = -20.032, z =  41.023 }
}

entity.phList =
{
    [ID.mob.PUU_TIMU_THE_PHANTASMAL - 2] = ID.mob.PUU_TIMU_THE_PHANTASMAL, -- Vanguard_Oracle
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Avatar')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
