-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Grand Marid
-----------------------------------
mixins = { require('scripts/mixins/families/marid'), require('scripts/mixins/families/chigoe_pet') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  137.000, y = -18.000, z =  334.000 }
}

return entity
