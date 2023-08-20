-----------------------------------
-- Doom
-- Description: Inflicts Doom upon an enemy.
-- Type: Magical (Dark)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DOOM

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 3, 30))

    return typeEffect
end

return mobskillObject
