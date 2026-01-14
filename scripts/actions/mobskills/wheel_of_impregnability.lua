-----------------------------------
-- Wheel of Impregnability
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        mob:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 1, 0, 0)
    skill:setFinalAnimationSub(1)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)

    return xi.effect.PHYSICAL_SHIELD
end

return mobskillObject
