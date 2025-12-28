-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Trailblix Goatmug
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
    { x =  33.958, y = -1.499, z = -56.897 }
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Slime')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
