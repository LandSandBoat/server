-----------------------------------
-- Slipstream
-- Used by Nightmare Gylas in Dynamis.
-- Reduces accuracy of targets in area of effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if target:hasStatusEffect(xi.effect.ACCURACY_DOWN) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, 40, 0, 90))

        return xi.effect.ACCURACY_DOWN
    end
end

return mobskillObject
