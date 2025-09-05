-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Bandrix Rockjaw
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
    { x = -37.337, y = -0.595, z = -49.359 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
