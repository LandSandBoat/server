-----------------------------------
-- Regeneration
--
-- Description: Adds a Regen xi.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if mob:hasStatusEffect(xi.effect.REGEN) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, 250, 3, 20))

        local effect = target:getStatusEffect(xi.effect.REGEN)
        if effect then
            effect:delEffectFlag(xi.effectFlag.DISPELABLE)
        end

        return xi.effect.REGEN
    end
end

return mobskillObject
