-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Wasabix Callusdigit
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
    { x =  19.399, y =  8.500, z = -35.754 }
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
