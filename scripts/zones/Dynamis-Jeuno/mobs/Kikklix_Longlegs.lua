-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Kikklix Longlegs
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
    { x = -55.608, y =  5.906, z = -0.608 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
