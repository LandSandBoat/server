-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Wraithdancer Gidbnod
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  317.606, y =  0.501, z =  17.761 }
}

entity.phList =
{
    [ID.mob.WRAITHDANCER_GIDBNOD - 2] = ID.mob.WRAITHDANCER_GIDBNOD, -- Vanguard_Amputator
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
