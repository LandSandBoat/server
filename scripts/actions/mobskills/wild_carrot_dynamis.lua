-----------------------------------
-- Wild Carrot
-- Family: Rabbit
-- Description: Restores HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}
    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = mob:getMaxHP()
    params.fTP =
    {
        { tp = 1000, modifier = 104 / 1024 },
        { tp = 2000, modifier = 104 / 1024 },
        { tp = 3000, modifier = 104 / 1024 },
    }

    mob:eraseAllStatusEffect()

    local effectsToRemove =
    {
        xi.effect.PETRIFICATION,
        xi.effect.PLAGUE,
        xi.effect.DISEASE,
        xi.effect.POISON,
        xi.effect.CURSE_I,
        xi.effect.CURSE_II,
        xi.effect.SILENCE,
        xi.effect.PARALYSIS,
        xi.effect.BLINDNESS,
    }

    for _, effect in ipairs(effectsToRemove) do
        mob:delStatusEffect(effect)
    end

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
