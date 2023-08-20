-----------------------------------
-- Goblin Dice
-- Description: AoE curse.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CURSE_I

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 300))

    return typeEffect
end

return mobskillObject
