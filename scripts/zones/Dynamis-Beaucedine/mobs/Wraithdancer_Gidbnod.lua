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

entity.phList =
{
    [ID.mob.WRAITHDANCER_GIDBNOD - 2] = ID.mob.WRAITHDANCER_GIDBNOD, -- Vanguard_Amputator
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
