-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Slinkix Trufflesniff
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
    { x =  120.960, y = -40.480, z =  0.800 }
}

entity.phList =
{
    [ID.mob.SLINKIX_TRUFFLESNIFF - 1] = ID.mob.SLINKIX_TRUFFLESNIFF, -- Vanguard_Ambusher
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
