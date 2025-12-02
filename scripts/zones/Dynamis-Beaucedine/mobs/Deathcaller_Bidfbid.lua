-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Deathcaller Bidfbid
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
    { x =  371.495, y = -0.163, z =  34.981 }
}

entity.phList =
{
    [ID.mob.DEATHCALLER_BIDFBID - 2] = ID.mob.DEATHCALLER_BIDFBID, -- Vanguard_Dollmaster
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Avatar')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
