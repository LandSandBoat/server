-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Shisox Widebrow
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
    { x =  81.708, y = -40.218, z =  5.133 }
}

entity.phList =
{
    [ID.mob.SHISOX_WIDEBROW - 2] = ID.mob.SHISOX_WIDEBROW, -- Vanguard_Ronin
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
