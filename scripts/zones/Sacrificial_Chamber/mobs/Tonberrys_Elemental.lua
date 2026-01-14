-----------------------------------
-- Area: Sacrificial Chamber
-- Name: Tonberrys Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local possibleTypes =
    {
        [1] = xi.pets.summon.type.FIRE_SPIRIT,
        [2] = xi.pets.summon.type.WATER_SPIRIT,
        [3] = xi.pets.summon.type.LIGHT_SPIRIT,
    }

    xi.pets.summon.setupSummon(mob, possibleTypes)
end

return entity
