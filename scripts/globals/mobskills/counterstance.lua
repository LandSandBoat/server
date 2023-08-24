-----------------------------------
-- Mobskill: Counterstance
-- Increases chance to counter but lowers defense.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(mob, target, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill)
    local typeEffect = xi.effect.COUNTERSTANCE
    local power = 20

    skill:setMsg(xi.mobskills.mobBuffMove(target, typeEffect, power, 3, 420))
    return typeEffect
end

return mobskillObject
