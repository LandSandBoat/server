-----------------------------------
-- Absorbing Kiss
-- Steal one effect
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- str down - chr down
    local effectType = math.random(136, 142)

    skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, effectType, 10, 3, 120))

    return 1
end

return mobskillObject
