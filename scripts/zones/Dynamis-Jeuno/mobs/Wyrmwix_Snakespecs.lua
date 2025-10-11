-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Wyrmwix Snakespecs
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
    { x =  29.040, y = -0.535, z = -21.201 }
}

entity.phList =
{
    [ID.mob.WYRMWIX_SNAKESPECS + 9] = ID.mob.WYRMWIX_SNAKESPECS, -- Vanguard_Enchanter    21.160   0.000   -7.386
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
