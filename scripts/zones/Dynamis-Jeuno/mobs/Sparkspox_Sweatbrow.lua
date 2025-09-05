-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Sparkspox Sweatbrow
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
    { x = -4.832, y =  2.400, z = -5.100 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
