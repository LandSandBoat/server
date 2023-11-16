-----------------------------------
-- Disorienting Waul
-- Description: Inflicts Amnesia on targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: ??' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.AMNESIA
    -- SubPower is resistance chance vs removal by Ecphoria Ring
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 35, 0, 60, 80))

    return typeEffect
end

return mobskillObject
