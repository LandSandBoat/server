-----------------------------------
-- Great Bleat
-- Description: Lowers maximum HP of targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 30, 0, 60))

    return xi.effect.MAX_HP_DOWN
end

return mobskillObject
