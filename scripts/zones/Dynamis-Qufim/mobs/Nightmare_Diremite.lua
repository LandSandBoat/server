-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Diremite
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
        xi.mobSkill.DOUBLE_CLAW_2,
        xi.mobSkill.GRAPPLE_2,
        xi.mobSkill.FILAMENTED_HOLD_2,
        xi.mobSkill.SPINNING_TOP_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
