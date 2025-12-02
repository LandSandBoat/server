-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Smeltix Thickhide
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
    { x =  4.606, y =  8.400, z = -51.115 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
