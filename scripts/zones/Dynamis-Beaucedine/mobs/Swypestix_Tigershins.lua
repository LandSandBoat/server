-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Swypestix Tigershins
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
    { x = -23.856, y = -40.625, z = -211.057 }
}

entity.phList =
{
    [ID.mob.SWYPESTIX_TIGERSHINS - 2] = ID.mob.SWYPESTIX_TIGERSHINS, -- Vanguard_Hitman
}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
