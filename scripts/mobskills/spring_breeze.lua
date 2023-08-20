-----------------------------------
-- Spring Breeze
-- Description: AoE TP-Reduction and Sleep xi.effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 20))
    target:setTP(target:getTP() * 0.5)

    return xi.effect.SLEEP_I
end

return mobskillObject
