-----------------------------------
--  Viscid Emission
--  Inflicts amnesia in an area of effect.
--  Type: Magical (Enfeebling)
--  Range: Unknown cone
--  Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.AMNESIA
    -- Subpower 100 prevents removal by Ecphoria Ring
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 60, 100))
    return typeEffect
end

return mobskillObject
