-----------------------------------
-- Riddle
--
-- Description: Reduces maximum MP in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 15' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_MP_DOWN, 42, 0, 120))

    return xi.effect.MAX_MP_DOWN
end

return mobskillObject
