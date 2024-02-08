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
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 60, 0, 300))

    return xi.effect.PROTECT
end

return mobskillObject
