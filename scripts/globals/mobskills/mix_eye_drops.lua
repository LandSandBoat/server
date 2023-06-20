-----------------------------------
-- Mix: Eye Drops - Removes Blindness.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:delStatusEffect(xi.effect.BLINDNESS)
    return 0
end

return mobskillObject
