-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Buffrix Eargone
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
    { x =  32.307, y = -0.500, z = -36.192 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
