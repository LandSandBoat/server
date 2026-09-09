-----------------------------------
-- Area: Sauromugue Champaign [S]
--  Mob: Yagudo's Elemental
-----------------------------------
require('scripts/globals/pets/summon')
-----------------------------------
---@type TMobEntity
local entity = {}

local possibleSpirits =
{
    xi.pets.summon.type.FIRE_SPIRIT,
    xi.pets.summon.type.AIR_SPIRIT,
    xi.pets.summon.type.EARTH_SPIRIT,
}

entity.onMobSpawn = function(mob)
    xi.pets.summon.setupSummon(mob, possibleSpirits, true)
end

return entity
