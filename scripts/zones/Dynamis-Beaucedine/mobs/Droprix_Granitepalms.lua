-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Droprix Granitepalms
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
    { x = -202.738, y = -40.620, z = -201.709 }
}

entity.phList =
{
    [ID.mob.DROPRIX_GRANITEPALMS - 2] = ID.mob.DROPRIX_GRANITEPALMS, -- Vanguard_Pitfighter
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
