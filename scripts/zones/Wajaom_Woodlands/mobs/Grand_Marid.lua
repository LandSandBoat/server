-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Grand Marid
-----------------------------------
mixins = { require('scripts/mixins/families/marid'), require('scripts/mixins/families/chigoe_pet') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  264.000, y = -23.000, z =  105.000 }
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
