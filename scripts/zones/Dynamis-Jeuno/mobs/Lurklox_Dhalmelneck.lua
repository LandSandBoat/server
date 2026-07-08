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

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

return entity
