-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Andras
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  69.122, y = -23.951, z = -221.793 }
}

entity.phList =
{
    [ID.mob.MARQUIS_ANDRAS - 2] = ID.mob.MARQUIS_ANDRAS, -- Kindred_Beastmaster
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Andrass_Vouivre')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
