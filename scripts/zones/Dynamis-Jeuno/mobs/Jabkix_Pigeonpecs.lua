-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Jabkix Pigeonpecs
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
    { x =  16.211, y =  8.502, z = -34.077 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
