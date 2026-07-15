-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Tonberry's Elemental
-----------------------------------
require('scripts/globals/pets/summon')
-----------------------------------
---@type TMobEntity
local entity = {}

local possibleSpirits =
{
    xi.pets.summon.type.FIRE_SPIRIT,
    xi.pets.summon.type.WATER_SPIRIT,
    xi.pets.summon.type.LIGHT_SPIRIT,
}

entity.onMobSpawn = function(mob)
    xi.pets.summon.setupSummon(mob, possibleSpirits)
end

return entity
