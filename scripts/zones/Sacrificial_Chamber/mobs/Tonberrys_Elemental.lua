-----------------------------------
-- Area: Sacrificial Chamber
-- Name: Tonberrys Elemental
-----------------------------------
mixins = { require('scripts/mixins/pet_summon_setup') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    local possibleSummons =
    {
        xi.pets.summon.type.FIRE_SPIRIT,
        xi.pets.summon.type.WATER_SPIRIT,
        xi.pets.summon.type.LIGHT_SPIRIT,
    }

    local summonBitmask = 0
    for _, entry in ipairs(possibleSummons) do
        utils.mask.setBit(summonBitmask, entry, true)
    end

    mob:setLocalVar('[Summon]mask', summonBitmask)
end

return entity
