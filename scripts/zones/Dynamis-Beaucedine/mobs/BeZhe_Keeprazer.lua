-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: BeZhe Keeprazer
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
    { x =  341.605, y =  0.535, z = -75.302 }
}

entity.phList =
{
    [ID.mob.BEZHE_KEEPRAZER - 2] = ID.mob.BEZHE_KEEPRAZER, -- Vanguard_Undertaker
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Avatar')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
