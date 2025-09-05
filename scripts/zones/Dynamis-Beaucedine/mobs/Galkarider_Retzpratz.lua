-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Galkarider Retzpratz
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
    { x =  356.355, y = -0.372, z =  6.558 }
}

entity.phList =
{
    [ID.mob.GALKARIDER_RETZPRATZ - 2] = ID.mob.GALKARIDER_RETZPRATZ, -- Vanguard_Predator
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
