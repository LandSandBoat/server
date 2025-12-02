-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Lurklox Dhalmelneck
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
    { x =  11.207, y =  2.500, z = -8.584 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
