-----------------------------------
-- Lowing
-- Description: AoE Powerful plague
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 0, 60))

    return xi.effect.PLAGUE
end

return mobskillObject
