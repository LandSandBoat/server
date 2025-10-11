-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Morgmox Moldnoggin
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -19.515, y =  2.988, z = -6.545 }
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Avatar')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
