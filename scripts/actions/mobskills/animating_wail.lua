-----------------------------------
-- Animating Wail
-- Family: Qutrub
-- Description: Let's out a wail that applies Haste to itself and nearby allies.
-- Type: Enhancing
-- Can be dispelled: Yes
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 1500
    local duration = 300

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, power, 0, duration))

    return xi.effect.HASTE
end

return mobskillObject
