-----------------------------------
-- Mix: Guard Drink - Applies Protect (+220 Defense) and Shell to all party members for 5 minutes.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:addStatusEffect(xi.effect.PROTECT, 220, 0, 300)
    target:addStatusEffect(xi.effect.SHELL, 2930, 0, 300)

    return 0
end

return mobskillObject
