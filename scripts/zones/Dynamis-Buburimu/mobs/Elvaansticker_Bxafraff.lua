-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Elvaansticker Bxafraff
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
    { x = -83.170, y = -14.960, z =  60.548 }
}

entity.phList =
{
    [ID.mob.ELVAANSTICKER_BXAFRAFF - 3] = ID.mob.ELVAANSTICKER_BXAFRAFF, -- Vanguard_Impaler
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Bxafraffs_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
