-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: QuPho Bloodspiller
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  204.165, y = -7.898, z =  29.621 }
}

entity.phList =
{
    [ID.mob.QUPHO_BLOODSPILLER - 12] = ID.mob.QUPHO_BLOODSPILLER, -- Vanguard_Vindicator
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
