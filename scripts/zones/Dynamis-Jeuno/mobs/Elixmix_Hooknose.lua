-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Elixmix Hooknose
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
    { x = -38.217, y = -0.495, z = -50.561 }
}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
