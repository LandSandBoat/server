-----------------------------------
-- Slumber Powder
-- 10' Conal sleep
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLEEP_I

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, 30))

    return typeEffect
end

return mobskillObject
