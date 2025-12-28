-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: GoTyo Magenapper
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
    { x =  326.480, y =  0.390, z = -134.520 }
}

entity.phList =
{
    [ID.mob.GOTYO_MAGENAPPER - 5] = ID.mob.GOTYO_MAGENAPPER, -- Vanguard_Drakekeeper
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
