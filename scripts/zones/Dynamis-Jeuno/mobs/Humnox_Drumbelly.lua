-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Humnox Drumbelly
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
    { x =  29.478, y = -0.495, z = -31.992 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
