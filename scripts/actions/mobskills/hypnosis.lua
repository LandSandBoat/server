-----------------------------------
-- Slumber Powder
-- 10' Conal sleep
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = xi.mobskills.calculateDuration(mob:getTP(), 45, 90)

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLEEP_I, 1, 0, duration))

    return xi.effect.SLEEP_I
end

return mobskillObject
