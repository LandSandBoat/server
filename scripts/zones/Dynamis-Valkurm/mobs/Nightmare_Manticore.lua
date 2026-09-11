-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Manticore
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
        xi.mobSkill.DEADLY_HOLD_1,
        xi.mobSkill.HEAT_BREATH_2,
        xi.mobSkill.RIDDLE_2,
        xi.mobSkill.GREAT_SANDSTORM_2,
        xi.mobSkill.GREAT_WHIRLWIND_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
