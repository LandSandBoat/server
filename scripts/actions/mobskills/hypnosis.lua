-----------------------------------
-- Slumber Powder
-- 10' Conal sleep
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30))

    return xi.effect.SLEEP_I
end

return mobskillObject
