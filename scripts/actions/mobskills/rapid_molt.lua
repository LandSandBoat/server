-----------------------------------
-- Rapid Molt
-- Family: Hpemde
-- Description: Erases all negative effects on the mob, and adds a Regen xi.effect.
-- Can be dispelled: Yes (regen)
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Hpemde will generally not attempt to use this ability if no erasable effects exist on them.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local dispel = target:eraseStatusEffect()

    if dispel ~= xi.effect.NONE then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:eraseAllStatusEffect()

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, 10, 3, 180))

    return xi.effect.REGEN
end

return mobskillObject
