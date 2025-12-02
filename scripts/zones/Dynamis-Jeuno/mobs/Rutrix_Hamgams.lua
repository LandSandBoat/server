-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Rutrix Hamgams
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
    { x = -14.354, y = -5.000, z =  66.490 }
}

entity.phList =
{
    [ID.mob.RUTRIX_HAMGAMS - 2] = ID.mob.RUTRIX_HAMGAMS, -- Vanguard_Dragontamer  0.144    1.756   43.922
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Slime')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
