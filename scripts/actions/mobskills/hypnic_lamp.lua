-----------------------------------
-- Hypnic Lamp
-- Description: Attempts to hypnotize targets in an area of effect.
-- Type: Enfeebling
-- Notes: Can't use this if its eyestalks are destroyed.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 120, 180)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLEEP_I, 1, 0, duration))

    return xi.effect.SLEEP_I
end

return mobskillObject
