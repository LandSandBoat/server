-----------------------------------
-- Area: Castle Zvahl Baileys
--  Mob: Demon's Elemental
-----------------------------------
require('scripts/globals/pets/summon')
-----------------------------------
---@type TMobEntity
local entity = {}

local possibleSpirits =
{
    xi.pets.summon.type.ICE_SPIRIT,
    xi.pets.summon.type.THUNDER_SPIRIT,
    xi.pets.summon.type.DARK_SPIRIT,
}

entity.onMobSpawn = function(mob)
    xi.pets.summon.setupSummon(mob, possibleSpirits, true)
end

return entity
