-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Fomor's Elemental
-----------------------------------
require('scripts/globals/pets/summon')
-----------------------------------
---@type TMobEntity
local entity = {}

local possibleSpirits =
{
    xi.pets.summon.type.DARK_SPIRIT,
}

entity.onMobSpawn = function(mob)
    xi.pets.summon.setupSummon(mob, possibleSpirits, true)
end

return entity
