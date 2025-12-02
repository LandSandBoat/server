-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Morblox Chubbychin
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
    { x =  138.194, y = -39.909, z = -71.004 }
}

entity.phList =
{
    [ID.mob.MORBLOX_CHUBBYCHIN - 2] = ID.mob.MORBLOX_CHUBBYCHIN, -- Vanguard_Necromancer
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Avatar')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
