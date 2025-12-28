-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Draklix Scalecrust
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
    { x =  29.043, y = -38.987, z = -169.157 }
}

entity.phList =
{
    [ID.mob.DRAKLIX_SCALECRUST - 2] = ID.mob.DRAKLIX_SCALECRUST, -- Vanguard_Dragontamer
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
