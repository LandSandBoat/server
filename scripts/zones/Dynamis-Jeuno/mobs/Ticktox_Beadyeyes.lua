-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Ticktox Beadyeyes
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
    { x = -10.025, y =  2.400, z = -5.321 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
