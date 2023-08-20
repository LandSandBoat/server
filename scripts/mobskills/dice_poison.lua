-----------------------------------
-- Goblin Dice
-- Description: Poison
-- Type: Physical (Blunt)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.POISON

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 15, 0, 60))
    return typeEffect
end

return mobskillObject
