-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Mithraslaver Debhabob
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
    { x =  239.870, y = -0.098, z =  228.050 }
}

entity.phList =
{
    [ID.mob.MITHRASLAVER_DEBHABOB - 2] = ID.mob.MITHRASLAVER_DEBHABOB, -- Vanguard_Hawker
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Hecteyes')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
