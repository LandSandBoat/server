-----------------------------------
-- Bubble Curtain
--
-- Description: Reduces magical damage received by 50%
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes:Nightmare Crabs use an enhanced version that applies a Magic Defense Boost that cannot be dispelled.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if mob:hasStatusEffect(xi.effect.MAGIC_DEF_BOOST) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return xi.effect.NONE
    else
        local result = xi.mobskills.mobBuffMove(target, xi.effect.MAGIC_DEF_BOOST, 900, 0, 30)
        local effect = target:getStatusEffect(xi.effect.MAGIC_DEF_BOOST)
        if effect then
            effect:delEffectFlag(xi.effectFlag.DISPELABLE)
        end

        skill:setMsg(result)

        return xi.effect.MAGIC_DEF_BOOST
    end
end

return mobskillObject
