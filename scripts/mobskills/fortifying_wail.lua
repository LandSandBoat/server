-----------------------------------
-- Fortifying Wail
-- Family: Qutrub
-- Description: Let's out a wail that applies Protect to itself and nearby allies.
-- Type: Enhancing
-- Can be dispelled: Yes
-- Utsusemi/Blink absorb: N/A
-- Range: AoE
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 60
    local duration = 300
    local typeEffect = xi.effect.PROTECT

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end

return mobskillObject
