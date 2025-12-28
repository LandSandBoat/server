-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Hermitrix Toothrot
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  31.785, y = -0.500, z = -25.679 }
}

entity.phList =
{
    [ID.mob.HERMITRIX_TOOTHROT - 1] = ID.mob.HERMITRIX_TOOTHROT, -- Vanguard_Enchanter    31.808   -0.566  -25.768
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
