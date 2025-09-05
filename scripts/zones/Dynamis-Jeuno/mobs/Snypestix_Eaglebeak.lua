-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Snypestix Eaglebeak
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
    { x =  1.370, y = -5.798, z =  38.835 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
