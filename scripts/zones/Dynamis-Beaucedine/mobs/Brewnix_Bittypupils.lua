-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Brewnix Bittypupils
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
    { x = -145.695, y = -40.505, z = -225.162 }
}

entity.phList =
{
    [ID.mob.BREWNIX_BITTYPUPILS + 3] = ID.mob.BREWNIX_BITTYPUPILS, -- Vanguard_Alchemist
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
