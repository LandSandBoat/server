-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Crab
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('dynamis_currency', 1449)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.BUBBLE_SHOWER_2,
        xi.mobSkill.BUBBLE_CURTAIN_2,
        xi.mobSkill.BIG_SCISSORS_2,
        xi.mobSkill.SCISSOR_GUARD_2,
        xi.mobSkill.METALLIC_BODY_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
